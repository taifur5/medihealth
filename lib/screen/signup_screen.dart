import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  final String role;

  const SignUpScreen({required this.role, super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _qualificationController = TextEditingController();

  bool _isLoading = false;

  Future<void> signUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Ensure all fields are filled
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          (widget.role == 'doctor' && _qualificationController.text.isEmpty)) {
        throw Exception("Please fill in all required fields.");
      }

      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Get UID
      String uid = userCredential.user!.uid;

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'role': widget.role,
        if (widget.role == 'doctor')
          'qualification': _qualificationController.text.trim(),
      });

      // Navigate to respective dashboard
      Navigator.pushReplacementNamed(
        context,
        widget.role == 'doctor' ? '/doctor_dashboard' : '/patient_dashboard',
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Handle Firebase Auth specific errors
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "The email is already in use by another account.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'weak-password':
          errorMessage = "The password is too weak.";
          break;
        default:
          errorMessage = "Authentication error: ${e.message}";
      }

      // Show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } on FirebaseException catch (e) {
      // Handle Firestore errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Database error: ${e.message}")),
      );
    } catch (e) {
      // Handle other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Your Account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              if (widget.role == 'doctor')
                TextField(
                  controller: _qualificationController,
                  decoration: const InputDecoration(
                    labelText: 'Qualification (e.g., Therapist, Cardiologist)',
                  ),
                ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: signUp,
                        child: const Text('Sign Up'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

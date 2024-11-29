// Import necessary dependencies for Firebase and navigation
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medihealth/screen/home_screen.dart';

class DoctorSignUpScreen extends StatefulWidget {
  const DoctorSignUpScreen({super.key});

  @override
  State<DoctorSignUpScreen> createState() => _DoctorSignUpScreenState();
}

class _DoctorSignUpScreenState extends State<DoctorSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  List<String> symptoms = ["Fever", "Cough", "Cold", "Snuffle", "Headache", "Pain"];
  List<String> selectedSymptoms = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerDoctor() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create a new user with email and password
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        String uid = userCredential.user!.uid;

        // Save additional doctor details to Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': _nameController.text,
          'email': _emailController.text,
          'role': 'doctor',
          'qualification': _qualificationController.text,
          'symptoms': selectedSymptoms,
        });

        // Navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        // Show an error message if registration fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Sign-Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => value!.isEmpty ? "Name is required" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Email is required" : null,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) =>
                    value!.length < 6 ? "Password must be at least 6 characters" : null,
                obscureText: true,
              ),
              TextFormField(
                controller: _qualificationController,
                decoration: const InputDecoration(labelText: "Qualification"),
                validator: (value) => value!.isEmpty ? "Qualification is required" : null,
              ),
              const SizedBox(height: 10),
              const Text("Symptoms You Treat:", style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: symptoms.map((symptom) {
                  bool isSelected = selectedSymptoms.contains(symptom);
                  return FilterChip(
                    label: Text(symptom),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        isSelected
                            ? selectedSymptoms.remove(symptom)
                            : selectedSymptoms.add(symptom);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerDoctor,
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

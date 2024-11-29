import 'package:flutter/material.dart';
import 'patient_signup_screen.dart';
import 'doctor_signup_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Role"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorSignUpScreen(),
                  ),
                );
              },
              child: const Text("Sign Up as Doctor"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PatientSignUpScreen(),
                  ),
                );
              },
              child: const Text("Sign Up as Patient"),
            ),
          ],
        ),
      ),
    );
  }
}

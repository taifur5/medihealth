import 'package:flutter/material.dart';
import 'package:medihealth/screen/patient_dashboard.dart';
import 'package:medihealth/screen/login_screen.dart';
import 'package:medihealth/screen/role_selection_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PatientDashboard(),
                      ),
                    );
                  },
                  child: const Text(
                    "SKIP",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset("images/doctor1.jpg"), // Ensure asset path is correct
              ),
              const SizedBox(height: 50),
              const Text(
                "DOCTOR APPOINTMENT",
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 125, 201),
                  fontWeight: FontWeight.bold,
                  wordSpacing: 2,
                  letterSpacing: 1,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Appoint your letter",
                style: TextStyle(
                  color: Color.fromARGB(255, 52, 50, 46),
                  fontWeight: FontWeight.w300,
                  wordSpacing: 2,
                  letterSpacing: 1,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    color: Colors.blue,
                    shadowColor: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.blue,
                    shadowColor: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RoleSelectionScreen(),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.green,
                shadowColor: Colors.greenAccent,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PatientDashboard(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    child: Text(
                      "Continue as Patient",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

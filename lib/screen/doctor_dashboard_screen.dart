import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  _DoctorDashboardScreenState createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  String userName = '';
  String qualifications = '';
  String role = '';

  @override
  void initState() {
    super.initState();
    fetchDoctorData();
  }

  Future<void> fetchDoctorData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    
    // Safely handle the data
    var data = userDoc.data() as Map<String, dynamic>?;
    
    setState(() {
      userName = data?['name'] ?? 'Unknown';
      role = data?['role'] ?? 'Unknown';
      qualifications = data != null && data.containsKey('qualification') 
          ? data['qualification'] 
          : 'Not available';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 107, 156),
        title: Text('Welcome, Dr. $userName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor's Profile Section
            Text(
              "Doctor Profile",
              style: Theme.of(context).textTheme.headlineLarge, // This can be updated if needed
            ),
            const SizedBox(height: 10),
            Text("Name: $userName"),
            Text("Role: $role"),
            Text("Qualifications: $qualifications"),
            const SizedBox(height: 20),

            // Action buttons for doctor functionalities
            ElevatedButton(
              onPressed: () {
                // Navigate to manage appointments screen             (you can create this screen)
                Navigator.pushNamed(context, 'AppointmentsScreen');
              },
              child: const Text("Manage Appointments"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to view patient details screen           (you can create this screen)
                Navigator.pushNamed(context, 'PatientDetailsScreen');
              },
              child: const Text("View Patient Details"),
            ),
            const SizedBox(height: 20),

            // Log out button
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}

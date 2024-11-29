import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  String patientName = '';
  String patientSymptoms = '';
  String patientMedicalHistory = '';
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appointment = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    fetchPatientDetails(appointment['patientName']);
  }

  Future<void> fetchPatientDetails(String patientName) async {
    try {
      // Replace this with actual data fetch from Firestore for the patient
      DocumentSnapshot patientDoc = await FirebaseFirestore.instance
          .collection('patients')  // assuming a 'patients' collection exists
          .doc(patientName)  // assuming the document ID is patient's name
          .get();

      setState(() {
        patientSymptoms = patientDoc['symptoms'] ?? 'No symptoms recorded';
        patientMedicalHistory = patientDoc['medicalHistory'] ?? 'No history available';
      });
    } catch (e) {
      print('Error fetching patient details: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to fetch patient details')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 107, 156),
        title: const Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Patient Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Name: $patientName"),
            const SizedBox(height: 10),
            Text("Symptoms: $patientSymptoms"),
            const SizedBox(height: 10),
            Text("Medical History: $patientMedicalHistory"),
            const SizedBox(height: 20),

            // Additional actions for doctors can go here
            ElevatedButton(
              onPressed: () {
                // Add actions like prescribing medication, scheduling follow-up, etc.
              },
              child: const Text('Schedule Follow-up Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}

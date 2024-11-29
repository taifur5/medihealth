import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medihealth/screen/chat_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  final String doctorId;

  const DoctorProfileScreen({super.key, required this.doctorId});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  late Map<String, dynamic> doctorData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoctorData();
  }

  Future<void> fetchDoctorData() async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.doctorId)
        .get();

    setState(() {
      doctorData = docSnapshot.data() as Map<String, dynamic>;
      isLoading = false;
    });
  }

  void bookAppointment() async {
    String patientId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('appointments').add({
      'doctorId': widget.doctorId,
      'patientId': patientId,
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'pending',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Appointment request sent successfully!")),
    );
  }

  void openChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(doctorId: widget.doctorId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Dr. ${doctorData['name']}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor's details
            Text(
              "Dr. ${doctorData['name']}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Specialization: ${doctorData['qualification']}"),
            const SizedBox(height: 8),
            Text("Rating: ${doctorData['rating'] ?? 'N/A'}"),
            const SizedBox(height: 16),

            // Appointment Booking
            ElevatedButton.icon(
              onPressed: bookAppointment,
              icon: const Icon(Icons.calendar_today),
              label: const Text("Book Appointment"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 46, 107, 156),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
            const SizedBox(height: 16),

            // Chat functionality
            ElevatedButton.icon(
              onPressed: openChat,
              icon: const Icon(Icons.chat),
              label: const Text("Send Message"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

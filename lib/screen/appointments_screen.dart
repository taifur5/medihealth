import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _patientNameController = TextEditingController();

  Future<void> addAppointment() async {
    try {
      String doctorId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('appointments').add({
        'doctorId': doctorId,
        'patientName': _patientNameController.text,
        'date': _dateController.text,
        'time': _timeController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment added successfully')));
      setState(() {
        _patientNameController.clear();
        _dateController.clear();
        _timeController.clear();
      });
    } catch (e) {
      print('Error adding appointment: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to add appointment')));
    }
  }

  Future<List<Map<String, dynamic>>> fetchAppointments() async {
    String doctorId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('doctorId', isEqualTo: doctorId)
        .get();

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 107, 156),
        title: const Text('Manage Appointments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add New Appointment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _patientNameController,
              decoration: const InputDecoration(labelText: 'Patient Name'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Time (HH:MM)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addAppointment,
              child: const Text('Add Appointment'),
            ),
            const SizedBox(height: 30),
            const Text('Your Appointments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchAppointments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching appointments'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No appointments yet.'));
                }

                var appointments = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    var appointment = appointments[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(appointment['patientName']),
                        subtitle: Text('Date: ${appointment['date']} Time: ${appointment['time']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.info),
                          onPressed: () {
                            // Navigate to patient details screen with appointment info
                            Navigator.pushNamed(context, '/patient_details', arguments: appointment);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

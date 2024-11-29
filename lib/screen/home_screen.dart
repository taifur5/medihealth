import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'doctor_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String role = '';
  String? selectedSymptom;
  List<Map<String, dynamic>> doctorList = [];
  TextEditingController searchController = TextEditingController();

  // List of Symptoms (Static Example)
  final List<String> symptoms = ["Cough", "Cold", "Fever", "Headache", "Skin Rash", "Diabetes"];

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchDoctors();
  }

  Future<void> fetchUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    // Extract user data safely
    var data = userDoc.data() as Map<String, dynamic>?;

    setState(() {
      userName = data?['name'] ?? 'Unknown';
      role = data?['role'] ?? 'Unknown';
    });
  }

  Future<void> fetchDoctors() async {
    QuerySnapshot doctorSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'doctor')
        .get();

    setState(() {
      doctorList = doctorSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
          'specialization': doc['qualification'],
          'rating': doc['rating'] ?? '4.5', // Default rating if not provided
        };
      }).toList();
    });
  }

  void filterDoctors(String symptom) {
    setState(() {
      selectedSymptom = symptom;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter doctors dynamically based on selected symptom
    List<Map<String, dynamic>> filteredDoctors = doctorList.where((doctor) {
      if (selectedSymptom == null || selectedSymptom!.isEmpty) return true;
      return doctor['specialization'].toLowerCase().contains(selectedSymptom!.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 107, 156),
        title: Text('Welcome $userName'),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("images/doctor1.jpg"),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Header
            Text(
              role == 'doctor'
                  ? "Welcome Doctor $userName"
                  : "Welcome Patient $userName",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Doctor Interface: Notifications
            if (role == 'doctor') ...[
              const Text("Patient Messages", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              // Placeholder for notifications (expand with actual notifications later)
              const Text("You have no new messages.", style: TextStyle(color: Colors.grey)),
            ],

            // Patient Interface: Symptoms and Popular Doctors
            if (role == 'patient') ...[
              const Text(
                "Search Symptoms",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              // Search bar
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Enter symptom...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onChanged: (query) => filterDoctors(query),
              ),
              const SizedBox(height: 10),
              // Symptoms Horizontal List
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: symptoms.length,
                  itemBuilder: (context, index) {
                    String symptom = symptoms[index];
                    return GestureDetector(
                      onTap: () => filterDoctors(symptom),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: selectedSymptom == symptom
                              ? const Color.fromARGB(255, 46, 107, 156)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                        ),
                        child: Center(
                          child: Text(
                            symptom,
                            style: TextStyle(
                              color: selectedSymptom == symptom ? Colors.white : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Popular Doctors Section
              const Text(
                "Popular Doctors",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              // Filtered Doctors Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> doctor = filteredDoctors[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorProfileScreen(doctorId: doctor['id']),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/doctor1.jpg"), // Replace with dynamic image
                          ),
                          const SizedBox(height: 10),
                          Text(
                            doctor['name'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            doctor['specialization'],
                            style: const TextStyle(color: Colors.black45),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.star, color: Colors.yellow, size: 16),
                              Text(
                                doctor['rating'],
                                style: const TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'screen/homepage.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

 // Your main screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(const MEDICO());
}



class MEDICO extends StatelessWidget{
  const MEDICO({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:WelcomeScreen(),
      

    );
  }
}
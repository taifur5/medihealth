import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int buttonIndex=0;

  final ScheduleWidgets=[
  //UpcomingSchedule(),
  const Center(
    child: Text("Upcoming"),
  ),
 const Center(
  child: Text("Completed"),
),
 
 const Center(
  child: Text("Canceld"),
 ),
  //UpcomingSchedule(),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top:40 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Schedule",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 249, 246, 246),
              borderRadius: BorderRadius.circular(10),

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      buttonIndex=0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 25),
                    decoration: BoxDecoration(
                       color: buttonIndex==0 ? const Color(0xFF7165D6) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("Upcoming",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("Completed",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("Canceled",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          const SizedBox(height: 30),
                ScheduleWidgets[buttonIndex],

        
        ],
      ),
    );
  }
}


              
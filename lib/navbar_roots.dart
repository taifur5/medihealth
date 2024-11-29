import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medihealth/screen/home_screen.dart';
import 'package:medihealth/screen/schedule_screen.dart';
import 'package:medihealth/screen/setting_screen.dart';
class NavBarRoots extends StatefulWidget{
  const NavBarRoots({super.key});

  @override
  State<NavBarRoots> createState() => _NavbarRootsState();
}

class _NavbarRootsState extends State<NavBarRoots> {
  @override
 int _selectedIndex=0;
 final _screens =[
  const HomeScreen(),
  Container(),
 
  const ScheduleScreen(),
   const SettingScreen(),
 
 ];
@override
 Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: Colors.white,
    body: _screens[_selectedIndex],
    bottomNavigationBar: SizedBox(
      height: 80,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        type:BottomNavigationBarType.fixed,
        selectedItemColor:const Color.fromARGB(255, 58, 115, 161),
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        currentIndex: _selectedIndex,
        onTap: (index){
          setState((){
            _selectedIndex=index;
          }
          );
        },
        items: const [BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
        label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chat_bubble_text_fill),
          label: "Message",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: "Schedule",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
        
        ],

        ),
    
    ),

  );
 }
  
 }

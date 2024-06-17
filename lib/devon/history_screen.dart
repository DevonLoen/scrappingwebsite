import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scrappingwebsite/devon/home_screen.dart';
import 'package:scrappingwebsite/devon/profile_screen.dart';

class History_screen extends StatefulWidget {
  const History_screen({super.key});

  @override
  State<History_screen> createState() => _History_screenState();
}

class _History_screenState extends State<History_screen> {
  int _selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("History"),
        backgroundColor: Color(0xFFFF9900),
      ),
      body: Center(
        child: Text('History'),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color(0xFFFF9900),
        index: _selectedindex,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.person_outline, size: 30),
        ],
        onTap: (index) {
          // _selectedindex = 1;
          //Handle button tap
          if (index == 0) {
            //           Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Signup_screen()),
            // );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home_screen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile_screen()),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:scrappingwebsite/history_screen.dart';
import 'package:scrappingwebsite/home_screen.dart';
import 'package:scrappingwebsite/profile_screen.dart';

class Dashboard_screen extends StatefulWidget {
  @override
  _Dashboard_screenState createState() => _Dashboard_screenState();
}

class _Dashboard_screenState extends State<Dashboard_screen> {
  int _selectedIndex = 2;

  final List<Widget> _children = [
    History_screen(),
    Center(child: Text('card screen')),
    Home_screen(),
    Profile_screen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Convex Bottom Bar Example'),
      // ),
      body: _children[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        color: Colors.white,
        backgroundColor: Colors.orange,
        items: [
          TabItem(icon: Icons.description_outlined),
          TabItem(icon: Icons.shopping_cart_outlined),
          TabItem(icon: Icons.home_outlined),
          TabItem(icon: Icons.person_outlined),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: onTabTapped,
      ),
    );
  }
}

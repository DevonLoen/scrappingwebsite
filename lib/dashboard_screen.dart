import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:scrappingwebsite/devon/history_screen.dart';
import 'package:scrappingwebsite/devon/home_screen.dart';
import 'package:scrappingwebsite/devon/profile_screen.dart';
import 'package:scrappingwebsite/tian/CartPage.dart';

class Dashboard_screen extends StatefulWidget {
  final int selectedIndex;

  const Dashboard_screen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  _Dashboard_screenState createState() => _Dashboard_screenState();
}

class _Dashboard_screenState extends State<Dashboard_screen> {
  int _selectedIndex = 2;
  bool firsttime = true;

  final List<Widget> _children = [
    History_screen(),
    CartPage(),
    Home_screen(),
    Profile_screen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      firsttime = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = firsttime ? widget.selectedIndex : _selectedIndex;

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

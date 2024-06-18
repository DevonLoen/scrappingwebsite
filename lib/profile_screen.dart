import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scrappingwebsite/history_screen.dart';
import 'package:scrappingwebsite/home_screen.dart';

import 'package:provider/provider.dart';
import 'package:scrappingwebsite/user_provider.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  int _selectedindex = 3;
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userListProvider = Provider.of<UserListProvider>(context);
    final userList = userListProvider.onlineusers;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFF9900),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.shopping_cart_outlined),
          //   onPressed: () {
          //     // Lakukan sesuatu saat ikon diklik
          //     print('Ikon diklik');
          //   },
          // ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Lakukan sesuatu saat item dipilih
              print('Anda memilih: $value');
            },
            itemBuilder: (BuildContext context) {
              return {'Pilihan 1', 'Pilihan 2', 'Pilihan 3'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            // color: Colors.blue,
            decoration: BoxDecoration(
              color: Color(0xFFFF9900),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(150),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFFB03A), // Warna bayangan
                  spreadRadius: 15, // Jangkauan bayangan
                  // blurRadius: 10, // Jarak blur bayangan
                  // offset: Offset(4, 4), // Offset bayangan (x, y)
                ),
              ],
            ),
            width: double.infinity,
            height: 140.0,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  color: Color(0xFFFF9900),
                  elevation: 0,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userList[0].name,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          userList[0].email,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Card(
            // color: Colors.blue,
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Alamat',
                    style: TextStyle(
                      fontSize: 17.0,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    userList[0].address,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            endIndent: 10,
            indent: 10,
          ),
          Card(
            // color: Colors.blue,
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nomor HP',
                    style: TextStyle(
                      fontSize: 17.0,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    userList[0].number,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            endIndent: 10,
            indent: 10,
          ),
          Card(
            // color: Colors.blue,
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tempat, Tanggal Lahir',
                    style: TextStyle(
                      fontSize: 17.0,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    userList[0].birth,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            endIndent: 10,
            indent: 10,
          ),
          Card(
            // color: Colors.blue,
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Jenis Kelamin',
                    style: TextStyle(
                      fontSize: 17.0,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    userList[0].gender,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            endIndent: 10,
            indent: 10,
          ),
        ],
      ),
    );
  }
}

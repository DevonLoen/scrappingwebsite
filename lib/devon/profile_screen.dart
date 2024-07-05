import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scrappingwebsite/devon/history_screen.dart';
import 'package:scrappingwebsite/devon/home_screen.dart';

import 'package:provider/provider.dart';
import 'package:scrappingwebsite/devon/login_screen.dart';
import 'package:scrappingwebsite/devon/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  bool dataFethced = false;
  void fetchToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login_screen()),
      );
    }

    decodedToken = Jwt.parseJwt(token!);

    // Use decodedToken data as needed
    print(decodedToken); // Example: Print decoded token data
    setState(() {
      dataFethced = true;
    });
  }

  int _selectedindex = 3;
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  Map<String, dynamic>? decodedToken;

  @override
  Widget build(BuildContext context) {
    final userListProvider = Provider.of<UserListProvider>(context);
    final userList = userListProvider.Users;
    return dataFethced
        ? Scaffold(
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
                  onSelected: (String value) async {
                    // Lakukan sesuatu saat item dipilih
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('token', '');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login_screen()),
                    );
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Log Out'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons
                                .logout_outlined), // Ganti dengan ikon yang Anda inginkan
                            SizedBox(
                                width:
                                    8), // Tambahkan jarak antara ikon dan teks
                            Text(choice),
                          ],
                        ),
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
                                decodedToken!['first_name'] ?? '-',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                decodedToken!['email'] ?? '-',
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
                          decodedToken!['address'] ?? '-',
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
                          decodedToken!['phone_number'].toString() ?? '-',
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
                          '-',
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
                          decodedToken!['gender'] ?? '-',
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
          )
        : CircularProgressIndicator();
  }
}

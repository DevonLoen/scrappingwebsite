import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrappingwebsite/dashboard_screen.dart';
import 'package:scrappingwebsite/devon/user_provider.dart';
// import 'package:scrappingwebsite/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:scrappingwebsite/devon/user_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  bool _obscureText = true;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String email = 'jer@gmail.com';
  String password = '123456';

  bool _isChecked = false;

  List<User> isUserAuthenticated(List<User> userList) {
    List<User> authenticatedUsers = [];

    for (var user in userList) {
      if (user.email == _emailController.text &&
          user.password == _passwordController.text) {
        User loginUser = User(
            first_name: "tian",
            last_name: "devon",
            email: user.email,
            password: "",
            phone_number: 081360441400,
            address: user.address.isNotEmpty ? user.address : "-",
            role: "client");
        authenticatedUsers
            .add(loginUser); // Autentikasi berhasil, tambahkan user ke list
      }
    }
    return authenticatedUsers; // Mengembalikan list kosong atau list user yang diautentikasi
  }

  void saveData(name, pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', name);
    await prefs.setString('password', pass);
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? "";
      password = prefs.getString('password') ?? "";
      _passwordController.text = password;
      _emailController.text = email;
    });
    // print('email: $email, Password: $password');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final itemListProvider = Provider.of<UserListProvider>(context);
    // final itemList = itemListProvider.Users;

    final userListProvider = Provider.of<UserListProvider>(context);
    final userList = userListProvider.Users;

    return Scaffold(
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
            height: 180.0,
            child: Text(''),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Log In',
            style: TextStyle(
              fontSize: 35, // Ukuran font
              // fontStyle: FontStyle.italic, // Gaya font (miring)
              fontWeight: FontWeight.bold, // Berat font (tebal)
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'email',
                prefixIcon: Icon(Icons.mail), // Ikon di depan TextField
              ),
              keyboardType: TextInputType.emailAddress,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter,
                // FilteringTextInputFormatter.emailCharactersOnly,
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _passwordController,
              obscureText: _obscureText, // Hide password input
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock), // Ikon di depan TextField
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText = _obscureText ? false : true;
                      });
                    },
                    child: Icon(Icons.remove_red_eye)),
                // suffixIcon: Icon(Icons.check),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        // Warna latar belakang ketika checkbox dicentang
                        if (states.contains(MaterialState.selected)) {
                          return Colors
                              .orange; // Warna orange ketika checkbox dicentang
                        }
                        // Warna latar belakang ketika checkbox tidak dicentang
                        return Colors.white;
                      }),
                    ),
                    Text('Remember Me'),
                  ],
                ),
                InkWell(
                  onTap: () {
                    // Tindakan yang ingin dilakukan saat CircleAvatar diklik
                    print('forgotpassword diklik!');
                  },
                  borderRadius: BorderRadius.circular(
                      5), // Membuat efek ink menyesuaikan bentuk CircleAvatar
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Color(0xFFCACACA),
              backgroundColor: Colors.orange,
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27.10)),
              minimumSize: Size(200, 45),
              shadowColor: Colors.black,
            ),
            onPressed: () async {
              try {
                await Provider.of<Auth>(context, listen: false).login(
                    _emailController.text, _passwordController.text, context);
              } catch (e) {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.error,
                  body: Center(
                    child: Text(
                      'Your Login Is Failed',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  title: 'This is Ignored',
                  desc: 'This is also Ignored',
                  btnOkColor: Colors.red,
                  btnOkOnPress: () {},
                ).show();
              }
              _isChecked
                  ? saveData(_emailController.text, _passwordController.text)
                  : null;
            },
            child: Text('Log In'),
          ),
          // SizedBox(
          //   height: 100,
          // ),
          // Row(
          //   // crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Divider(
          //         color: Colors.grey,
          //         thickness: 1,
          //         indent: 30,
          //         endIndent: 10, // Jarak antara Divider dan teks
          //       ),
          //     ),
          //     Text(
          //       ' Or login with ',
          //       style: TextStyle(color: Colors.grey),
          //     ),
          //     Expanded(
          //       child: Divider(
          //         color: Colors.grey,
          //         thickness: 1,
          //         indent: 10, // Jarak antara Divider dan teks
          //         endIndent: 30, // Jarak antara Divider dan teks
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         // Tindakan yang ingin dilakukan saat CircleAvatar diklik
          //         print('CircleAvatar diklik!');
          //       },
          //       borderRadius: BorderRadius.circular(
          //           5), // Membuat efek ink menyesuaikan bentuk CircleAvatar
          //       child: CircleAvatar(
          //           radius: 18, backgroundColor: Colors.blue, child: Text('')),
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     InkWell(
          //       onTap: () {
          //         // Tindakan yang ingin dilakukan saat CircleAvatar diklik
          //         print('CircleAvatar diklik!');
          //       },
          //       borderRadius: BorderRadius.circular(
          //           5), // Membuat efek ink menyesuaikan bentuk CircleAvatar
          //       child: CircleAvatar(
          //           radius: 18, backgroundColor: Colors.blue, child: Text('')),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

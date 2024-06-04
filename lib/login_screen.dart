import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scrappingwebsite/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:scrappingwebsite/user_provider.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String email = '';
  String password = '';

  bool _isChecked = false;

  bool isUserAuthenticated(List<Item> itemList) {
    for (var item in itemList) {
      if (item.email == _emailController.text &&
          item.password == _passwordController.text) {
        return true;
      }
    }
    return false;
  }

  void saveData(name, pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', name);
    await prefs.setString('password', pass);
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email')!;
      password = prefs.getString('password')!;
      _passwordController.text = password;
      _emailController.text = email;
    });
    // print('Email: $email, Password: $password');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final itemListProvider = Provider.of<ItemListProvider>(context);
    final itemList = itemListProvider.items;
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
                hintText: 'Email',
                prefixIcon: Icon(Icons.mail), // Ikon di depan TextField
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _passwordController,
              obscureText: true, // Hide password input
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock), // Ikon di depan TextField
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
            onPressed: () {
              if (isUserAuthenticated(itemList)) {
                _isChecked
                    ? saveData(_emailController.text, _passwordController.text)
                    : null;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home_screen()),
                );
              } else {
                print('login tidak tervalidasi');
              }
            },
            child: Text('Log In'),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 30,
                  endIndent: 10, // Jarak antara Divider dan teks
                ),
              ),
              Text(
                ' Or login with ',
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 10, // Jarak antara Divider dan teks
                  endIndent: 30, // Jarak antara Divider dan teks
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // Tindakan yang ingin dilakukan saat CircleAvatar diklik
                  print('CircleAvatar diklik!');
                },
                borderRadius: BorderRadius.circular(
                    5), // Membuat efek ink menyesuaikan bentuk CircleAvatar
                child: CircleAvatar(
                    radius: 18, backgroundColor: Colors.blue, child: Text('')),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  // Tindakan yang ingin dilakukan saat CircleAvatar diklik
                  print('CircleAvatar diklik!');
                },
                borderRadius: BorderRadius.circular(
                    5), // Membuat efek ink menyesuaikan bentuk CircleAvatar
                child: CircleAvatar(
                    radius: 18, backgroundColor: Colors.blue, child: Text('')),
              ),
            ],
          )
        ],
      ),
    );
  }
}

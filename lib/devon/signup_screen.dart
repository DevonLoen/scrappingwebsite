import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:project/Devon/providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:scrappingwebsite/devon/login_screen.dart';

// import 'package:scrappingwebsite/login_screen.dart';
import 'package:scrappingwebsite/devon/user_provider.dart';

class Signup_screen extends StatefulWidget {
  const Signup_screen({super.key});

  @override
  State<Signup_screen> createState() => _Signup_screenState();
}

class _Signup_screenState extends State<Signup_screen> {
  bool _obscureTextpwd = true;
  bool _obscureTextcnfrmpwd = true;

  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  String dropdown = "";

  @override
  Widget build(BuildContext context) {
    final userListProvider = Provider.of<UserListProvider>(context);
    final itemList = userListProvider.Users;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFFFF9900),
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
            height: 40,
            child: Text(''),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Sign Up',
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
              controller: _usernameController,
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Name',
                prefixIcon: Icon(Icons.person), // Ikon di depan TextField
              ),
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
          // SizedBox(
          //   height: 25,
          // ),
          // Container(
          //   width: 300,
          //   child: TextField(
          //     controller: _roleController,
          //     decoration: InputDecoration(
          //       // labelText: 'Password',
          //       hintText: 'Role',
          //       prefixIcon:
          //           Icon(Icons.business_center), // Ikon di depan TextField
          //     ),
          //   ),
          // ),
//           Container(
//             width: 310,
//             height: 55,
//             // padding: EdgeInsets.all(0),

//             // color: Colors.red,
//             child: DropdownButton<String>(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),

//               value: dropdownValue,
//               hint: Row(
//                 children: [
//                   SizedBox(
//                     width: 3,
//                   ),
//                   Icon(Icons.business_center,
//                       color: Colors.black), // Icon di sebelah kiri hint text
//                   SizedBox(width: 10),
//                   // Spasi antara ikon dan teks
//                   dropdown.isEmpty
//                       ? Text(
//                           'Select a Role',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                       : Text(dropdown)
//                 ],
//               ), // Hint text
//               icon: dropdown.isEmpty
//                   ? Icon(Icons.arrow_drop_down, color: Colors.black)
//                   : Icon(Icons.arrow_drop_down, color: Colors.white),
// // Icon di sebelah kanan
//               iconSize: 24,
//               elevation: 16,
//               style: TextStyle(color: Colors.black, fontSize: 16),
//               underline: Container(
//                 height: 1,
//                 color: Colors.black,
//               ),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   dropdownValue = newValue!;
//                   dropdown = newValue!;
//                 });
//                 print(newValue);
//               },
//               items: <String>['Manager', 'Karyawan', 'Babu', 'Christian']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//           ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _numberController,
              // obscureText: true, // Hide password input
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Number',
                prefixIcon: Icon(Icons.phone), // Ikon di depan TextField
                // suffixIcon: Icon(Icons.check),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
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
              obscureText: _obscureTextpwd, // Hide password input
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock), // Ikon di depan TextField
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureTextpwd = _obscureTextpwd ? false : true;
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
            child: TextField(
              controller: _confirmpasswordController,
              obscureText: _obscureTextcnfrmpwd, // Hide password input
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock), // Ikon di depan TextField
                // suffixIcon: Icon(Icons.check),
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureTextcnfrmpwd =
                            _obscureTextcnfrmpwd ? false : true;
                      });
                    },
                    child: Icon(Icons.remove_red_eye)),
              ),
            ),
          ),
          SizedBox(
            height: 30,
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
              if (_usernameController.text.isEmpty ||
                  _emailController.text.isEmpty ||
                  _numberController.text.isEmpty ||
                  _passwordController.text.isEmpty) {
                // Show dialog for empty username
                String errorMessage = "";
                if (_usernameController.text.isEmpty) {
                  errorMessage = 'Username is required.';
                } else if (_emailController.text.isEmpty) {
                  errorMessage = 'email is required.';
                  // } else if (dropdown.isEmpty) {
                  //   errorMessage = 'Role is required.';
                } else if (_numberController.text.isEmpty) {
                  errorMessage = 'Number is required.';
                } else if (_passwordController.text.isEmpty) {
                  errorMessage = 'Password is required.';
                }

                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.error,
                  body: Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  title: 'This is Ignored',
                  desc: 'This is also Ignored',
                  btnOkColor: Colors.red,
                  btnOkOnPress: () {},
                ).show();

                return;
              }

              if (_passwordController.text != _confirmpasswordController.text) {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.error,
                  body: Center(
                    child: Text(
                      'Confirm Password Is Incorrect',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  title: 'This is Ignored',
                  desc: 'This is also Ignored',
                  btnOkColor: Colors.red,
                  btnOkOnPress: () {},
                ).show();
                return;
              }
              print('ok');
              try {
                await Provider.of<Auth>(context, listen: false).signup(
                    _emailController.text,
                    _passwordController.text,
                    _usernameController.text,
                    'hello',
                    context);
              } catch (e) {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.error,
                  body: Center(
                    child: Text(
                      'Your SignUp Is Failed',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  title: 'This is Ignored',
                  desc: 'This is also Ignored',
                  btnOkColor: Colors.red,
                  btnOkOnPress: () {},
                ).show();
              }
            },
            child: Text('Sign Up'),
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
          //       ' Or signup with ',
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

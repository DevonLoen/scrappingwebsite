import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrappingwebsite/dashboard_screen.dart';
import 'package:scrappingwebsite/devon/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Role {
  static const String admin = 'admin';
  static const String client = 'client';
}

class User {
  final String email;
  final String password;
  final String first_name;
  final String last_name;
  final int phone_number;
  final String address;
  final String role;

  User(
      {required this.first_name,
      required this.last_name,
      required this.email,
      required this.password,
      required this.address,
      required this.phone_number,
      required this.role});
}

class UserListProvider extends ChangeNotifier {
  List<User> _Users = [
    User(
        first_name: 'first_name',
        last_name: "last_name",
        email: "email",
        password: "password",
        address: 'address',
        phone_number: 081360441400,
        role: Role.admin)
  ];

  List<User> get Users => _Users;

  void addUser(User User) {
    _Users.add(User);
    notifyListeners();
  }

  void removeUser(int index) {
    _Users.removeAt(index);
    notifyListeners();
  }
}

class Auth extends ChangeNotifier {
  String? _idToken;

  String? _tempidToken, tempuserId;

  bool get isAuth {
    print('_tempidTokendi atas');
    print(_tempidToken);
    return _tempidToken != null;
  }

  Future<void> tempData() async {
    _idToken = _tempidToken;

    notifyListeners();
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
          Uri.parse("http://localhost:3000/api/v1/users/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{"email": email, "password": password}));
      if (response.statusCode == 200) {
        prefs.setString('token', jsonDecode(response.body)['token']);
        _tempidToken = jsonDecode(response.body)['token'];
        print('_tempidToken tdi bawah');
        print(_tempidToken);
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: Center(
            child: Text(
              'Your Login Is Succeed',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnOkOnPress: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard_screen()),
          ),
        ).show();
        // Navigator.push(
        //     context, MaterialPageRoute(builder: ((context) => Home_screen())));
        return true;
      } else {
        throw (jsonDecode(response.body)['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}

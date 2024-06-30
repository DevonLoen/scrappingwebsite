import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrappingwebsite/dashboard_screen.dart';
import 'package:scrappingwebsite/devon/home_screen.dart';
import 'package:scrappingwebsite/tian/cartListProvider.dart';
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
          btnOkOnPress: () => Navigator.pushNamed(context, "/HomeScreen"),
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

Future<void> searchData() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    if (!prefs.containsKey('token')) {
      throw Exception("Please Logged in again");
    }
    ;
    final response = await http.get(
        Uri.parse("http://localhost:3000/api/v1/scrapping?search=panci"),
        headers: <String, String>{"Authorization": prefs.getString('token')!});
    if (jsonDecode(response.body)['error']) {
      prefs.clear();
      throw Exception("please log in again");
    }
    print('response search');
    print(response.body);
  } catch (e) {
    rethrow;
  }
}

Future<List<ItemCart>> getCart() async {
  final prefs = await SharedPreferences.getInstance();
  try {
    if (!prefs.containsKey('token')) {
      prefs.clear();
      throw Exception("Please Logged in again");
    }
    final response = await http.get(
        Uri.parse(
            'http://localhost:3000/api/v1/items/get-own?status=keranjang'),
        headers: <String, String>{"Authorization": prefs.getString('token')!});
    print('jsonDecode(respone.body)');
    print(jsonDecode(response.body));
    print(jsonDecode(response.body)['items'].runtimeType);
    final List<dynamic> jsonResponse = jsonDecode(response.body)['items'];
    print('jsonResponse');
    print(jsonResponse);
    final List<Map<String, dynamic>> itemsList =
        List<Map<String, dynamic>>.from(jsonResponse.map((value) => value));
    print('itemsList');
    print(itemsList);
    return ItemCart.fromJSON(itemsList);
    // List<Map<String, dynamic>> jsonList =
    //     jsonDecode(response.body).cast(Map<String, dynamic>);
    // return ItemCart.fromJSON(jsonList);
  } catch (e) {
    print("aaceemmm");
    print(e);
    rethrow;
  }
}

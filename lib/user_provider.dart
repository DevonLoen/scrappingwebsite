import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String name;
  final String email;
  final String password;
  final String number;
  final String address;
  final String birth;

  final String gender;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.number,
      required this.address,
      required this.birth,
      required this.gender});
}

class UserListProvider extends ChangeNotifier {
  List<User> _users = [
    User(
        name: "devon",
        email: "devonloen@gmail.com",
        password: "devon",
        number: "081375",
        address: "Jln Marelan",
        birth: "Medan ,04 Februari 2024",
        gender: "Laki-Laki"),
  ];

  List<User> _onlineusers = [];

  List<User> get users => _users;

  List<User> get onlineusers => _onlineusers;

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void removeUser(int index) {
    _users.removeAt(index);
    notifyListeners();
  }

  void updateUser(int index, User user) {
    _users[index] = user;
    notifyListeners();
  }

  void addOnlineUser(User onlineuser) {
    _onlineusers.add(onlineuser);
    notifyListeners();
  }

  void removeOnlineUser() {
    _onlineusers.removeAt(0);
    notifyListeners();
  }
}

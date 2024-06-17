import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});
}

class UserListProvider extends ChangeNotifier {
  List<User> _Users = [User(email: '123', password: '123', name: 'devon')];

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

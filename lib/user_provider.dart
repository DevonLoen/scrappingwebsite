import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Item {
  final String name;
  final String email;
  final String password;

  Item({required this.name, required this.email, required this.password});
}

class ItemListProvider extends ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

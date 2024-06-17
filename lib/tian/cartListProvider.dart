import 'package:flutter/material.dart';

class ItemCart {
  bool checked = false;
  final String image = "assets/logo.png";
  final String itemName;
  final String itemPrice;
  final String itemStore;
  int itemTotal;

  ItemCart(
      {required this.itemName,
      required this.itemPrice,
      required this.itemStore,
      required this.itemTotal});
}

class CartListProvider extends ChangeNotifier {
  List<ItemCart> LazadaCart = [
    ItemCart(
        itemName: "Adidas Samba",
        itemPrice: 'Rp. 2.100.000',
        itemStore: 'Toko Sepatu',
        itemTotal: 1),
    ItemCart(
        itemName: "Adidas Samba",
        itemPrice: 'Rp. 2.100.000',
        itemStore: 'Toko Sepatu',
        itemTotal: 1),
  ];
  List<ItemCart> BukalapakCart = [
    ItemCart(
        itemName: "Adidas Samba",
        itemPrice: 'Rp. 2.100.000',
        itemStore: 'Toko Sepatu',
        itemTotal: 1),
  ];
  List<ItemCart> TokopediaCart = [
    ItemCart(
        itemTotal: 1,
        itemName: "Adidas Samba",
        itemPrice: 'Rp. 2.100.000',
        itemStore: 'Toko Sepatu')
  ];

  void addItemTotalValue(CartList, index) {
    CartList[index].itemTotal += 1;
    notifyListeners();
  }

  void SubstractItemTotalValue(CartList, index) {
    if (CartList[index].itemTotal <= 0) return;
    CartList[index].itemTotal -= 1;
    notifyListeners();
  }

  void changeItemCheckedValue(CartList, index) {
    CartList[index].checked = !CartList[index].checked;
    notifyListeners();
  }
}

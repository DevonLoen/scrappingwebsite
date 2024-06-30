import 'package:flutter/material.dart';

class ItemCart {
  bool checked = false;
  final String image;
  final String itemName;
  final int itemPrice;
  final String itemStore;
  int itemTotal;

  static List<ItemCart> fromJSON(List<Map<String, dynamic>> jsonList) {
    print('json itemcart');
    print(jsonList);
    List<ItemCart> listCart = jsonList.map((json) {
      print('json');
      print(json);
      return ItemCart(
          itemName: json['nama_produk'],
          itemPrice: json['harga'],
          itemStore: json['nama_toko'],
          itemTotal: json['jumlah'],
          image: json['image_url']);
    }).toList();
    print('listCart');
    print(listCart);
    return listCart;
  }

  ItemCart(
      {required this.itemName,
      required this.itemPrice,
      required this.itemStore,
      required this.itemTotal,
      required this.image});
}

class CartListProvider extends ChangeNotifier {
  List<ItemCart> BukalapakCart = [
    ItemCart(
        itemName: "Adidas Samba",
        itemPrice: 2100000,
        itemStore: 'Toko Sepatu',
        image: "assets/logo.png",
        itemTotal: 1),
  ];
  List<ItemCart> TokopediaCart = [
    ItemCart(
        itemTotal: 1,
        itemName: "Adidas Samba",
        itemPrice: 2100000,
        image: "assets/logo.png",
        itemStore: 'Toko Sepatu')
  ];
  List<ItemCart> CheckedCart = [];
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
    if (CartList[index].checked) {
      CheckedCart.removeWhere((item) => CartList[index] == item);
    } else {
      CheckedCart.add(CartList[index]);
    }
    CartList[index].checked = !CartList[index].checked;
    print('CheckedCart');
    print(CheckedCart);
    notifyListeners();
  }

  List<ItemCart> get getCheckedCart => CheckedCart;
}

import "dart:js";

import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";
import "package:scrappingwebsite/tian/CartPage.dart";
import "package:scrappingwebsite/tian/cartListProvider.dart";

class PurchasePage extends StatefulWidget {
  PurchasePage({super.key});
  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  int? selectedDeliveryOptions;
  final List deliveryOptions = [
    {'type': "Priority", 'Estimation': "(Estimasi 1-2 Hari)", "Price": 50000},
    {'type': "Standard", 'Estimation': "(Estimasi 2-3 Hari)", "Price": 30000},
    {'type': "Saver", 'Estimation': "(Estimasi 4-5 Hari)", "Price": 20000}
  ];
  int deliveryPrice = 0;
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###', 'en_US');

    final CheckedCartList = Provider.of<CartListProvider>(context).CheckedCart;
    final cartListProvider = Provider.of<CartListProvider>(context);
    final CheckedCartListTes =
        ModalRoute.of(context)?.settings.arguments == null
            ? []
            : ModalRoute.of(context)?.settings.arguments as List<ItemCart>;
    print('acem');
    try {
      if (CheckedCartListTes.length != 0) {
        print('CheckedCartListTes.runtimeType');
        print(CheckedCartListTes.runtimeType);
        print(CheckedCartListTes[0].itemName);
      }
    } catch (e) {
      print('reror cuk');
      print(e);
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Purchase Now",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFF9900),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFFF9900), width: 1)),
              child: Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    ListTile(
                      leading:
                          Icon(IconData(0xe3ab, fontFamily: 'MaterialIcons')),
                      title: Text('Jl. M. H. Thamrin, Nomor 100A'),
                      subtitle: Text(
                        'Jl. M. H. Thamrin, Pusat Medan, Kota Medan, Sumatera Utara, Indonesia.',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 8),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 1,
                                  offset: Offset(0, 5))
                            ]),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "UBAH ALAMAT ",
                                style: TextStyle(
                                    color: Color(0xFFFF9900), fontSize: 12),
                              ),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(0)),
                                  side: MaterialStateProperty.all(
                                      BorderSide(color: Color(0xFFFF9900))),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 255, 255, 255)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius here
                                  ))),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text("Delivery Options"),
          ),
          Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedDeliveryOptions;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            setState(() {
                              deliveryPrice = deliveryOptions[index]['Price'];
                              selectedDeliveryOptions = index;
                            });
                          },
                          child: ListTile(
                            selected: isSelected,
                            selectedColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            selectedTileColor: Colors.amber,
                            leading: Text(
                              '${deliveryOptions[index]['type']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            title: isSelected
                                ? Text(
                                    '${deliveryOptions[index]["Estimation"]}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  )
                                : Text(
                                    '${deliveryOptions[index]["Estimation"]}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xFFFF9900)),
                                  ),
                            trailing: Text(
                              'RP. ${formatter.format(deliveryOptions[index]['Price'])}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
          SizedBox(
            height: 30,
          ),
          CartOrderWidget(
            MarketplaceName: "Order Summary",
            cartList: CheckedCartListTes,
            cartListProvider: cartListProvider,
            deliveryPrice: deliveryPrice,
          ),
          Container(
              margin: EdgeInsets.all(10), child: Text('Metode Pembayaran')),
          Pembayaran_widget(),
        ],
      ),
    );
  }
}

class CartOrderWidget extends StatelessWidget {
  CartOrderWidget(
      {super.key,
      required this.MarketplaceName,
      required this.cartList,
      required this.cartListProvider,
      required this.deliveryPrice});
  final int deliveryPrice;
  final String MarketplaceName;
  final List<dynamic> cartList;
  final CartListProvider cartListProvider;
  int totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###', 'en_US');

    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFFF9900)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '$MarketplaceName',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 150),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(cartList.length, (indexItem) {
                        totalPrice += (cartList[indexItem].itemPrice as int) *
                            cartList[indexItem].itemTotal as int;
                        return Container(
                          padding: indexItem == 0
                              ? EdgeInsets.only()
                              : EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(color: Color(0xFFFF9900))),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 1,
                                offset: Offset(0, 5), // Vertical shadow
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                        cartList[indexItem].image,
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartList[indexItem].itemName,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                  'RP. ${formatter.format(cartList[indexItem].itemPrice * cartList[indexItem].itemTotal)}')),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border(bottom: BorderSide(color: Color(0xFFFF9900))),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 1,
                          offset: Offset(0, 5), // Vertical shadow
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal Items",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text('RP. ${formatter.format(totalPrice)}',
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Fee",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text('RP. ${formatter.format(deliveryPrice)}',
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Admin Fee",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text("RP 5.000", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '${formatter.format(totalPrice + deliveryPrice + 5000)}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pembayaran_widget extends StatelessWidget {
  const Pembayaran_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              border: Border.all(
                color: Colors.amber, // Warna border
                width: 1, // Lebar border
              ),
            ),
            width: 160,
            height: 190,
            // color: Colors.amber,
            child: Column(
              children: [
                Text(
                  'Uang Elektronik',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                InkWell(
                  onTap: () {
                    print('ovo');
                  },
                  child: Container(
                    // color: Colors.red,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.amber, // Warna border
                        width: 1, // Lebar border
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),

                    child: Center(child: Text('ini adalah ovo')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('dana');
                  },
                  child: Container(
                    // color: Colors.red,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.amber, // Warna border
                        width: 1, // Lebar border
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),

                    child: Center(child: Text('ini adalah dana')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('gopay');
                  },
                  child: Container(
                    // color: Colors.red,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.amber, // Warna border
                        width: 1, // Lebar border
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),

                    child: Center(child: Text('ini adalah gopay')),
                  ),
                ),
              ],
            ),
          ),
          // bank
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              border: Border.all(
                color: Colors.amber, // Warna border
                width: 1, // Lebar border
              ),
            ),
            width: 160,
            height: 240,
            // color: Colors.amber,
            child: Column(
              children: [
                Text(
                  'Bank',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                InkWell(
                  onTap: () {
                    print('gopay');
                  },
                  child: Container(
                    // color: Colors.red,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.amber, // Warna border
                        width: 1, // Lebar border
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),

                    child: Center(child: Text('ini adalah bca')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('bca');
                  },
                  child: Container(
                    // color: Colors.red,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.amber, // Warna border
                        width: 1, // Lebar border
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),

                    child: Center(child: Text('ini adalah bri')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('bri');
                  },
                  child: Container(
                    // color: Colors.red,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.amber, // Warna border
                        width: 1, // Lebar border
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),

                    child: Center(child: Text('ini adalah mandiri')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('bni');
                  },
                  child: Container(
                    // color: Colors.red,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.amber, // Warna border
                        width: 1, // Lebar border
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),

                    child: Center(child: Text('ini adalah bni')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import "dart:js";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scrappingwebsite/tian/CartPage.dart";
import "package:scrappingwebsite/tian/cartListProvider.dart";

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  int? selectedDeliveryOptions;
  final List deliveryOptions = [
    {
      'type': "Priority",
      'Estimation': "(Estimasi 1-2 Hari)",
      "Price": "50.000"
    },
    {
      'type': "Standard",
      'Estimation': "(Estimasi 2-3 Hari)",
      "Price": "30.000"
    },
    {'type': "Saver", 'Estimation': "(Estimasi 4-5 Hari)", "Price": "20.000"}
  ];
  @override
  Widget build(BuildContext context) {
    final CheckedCartList = Provider.of<CartListProvider>(context).CheckedCart;
    final cartListProvider = Provider.of<CartListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                              '${deliveryOptions[index]['Price']}',
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
              cartList: CheckedCartList,
              cartListProvider: cartListProvider)
        ],
      ),
    );
  }
}

class CartOrderWidget extends StatelessWidget {
  const CartOrderWidget({
    super.key,
    required this.MarketplaceName,
    required this.cartList,
    required this.cartListProvider,
  });
  final String MarketplaceName;
  final List<ItemCart> cartList;
  final CartListProvider cartListProvider;

  @override
  Widget build(BuildContext context) {
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
                      children: List.generate(
                          cartList.length,
                          (indexItem) => Container(
                                padding: indexItem == 0
                                    ? EdgeInsets.only()
                                    : EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Color(0xFFFF9900))),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                              cartList[indexItem].image),
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
                                                  cartList[indexItem].itemName),
                                              Text("Size UK 30",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xFFFF9900))),
                                              Text('Color Black Doff',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xFFFF9900))),
                                              Expanded(
                                                child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child:
                                                        Text("RP 25.000.000")),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))),
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
                            Text("RP 3.300.000",
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
                            Text("RP 30.000", style: TextStyle(fontSize: 14)),
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
                          "RP 3.335.000",
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

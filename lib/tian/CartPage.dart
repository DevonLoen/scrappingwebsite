import "dart:js";

import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:scrappingwebsite/devon/home_screen.dart";
import "package:scrappingwebsite/devon/profile_screen.dart";
import "package:scrappingwebsite/devon/user_provider.dart";
import "package:scrappingwebsite/tian/cartListProvider.dart";
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedindex = 0;
    final cartListProvider = Provider.of<CartListProvider>(context);
    final BukalapakCartList =
        Provider.of<CartListProvider>(context, listen: false).BukalapakCart;
    final TokopediaCartList =
        Provider.of<CartListProvider>(context, listen: false).TokopediaCart;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFF9900),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width - 25),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              CartListViewWidget(
                  MarketplaceName: 'Bukalapak',
                  cartListProvider: cartListProvider),
              SizedBox(
                height: 20,
              ),
              CartListViewWidget(
                  MarketplaceName: "Tokopedia",
                  cartListProvider: cartListProvider),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/PurchasePage",
                        arguments: cartListProvider.getCheckedCart);
                  },
                  child: Text(
                    "Beli Sekarang",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF9900),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CartListViewWidget extends StatefulWidget {
  const CartListViewWidget({
    super.key,
    required this.MarketplaceName,
    required this.cartListProvider,
  });
  final String MarketplaceName;
  final CartListProvider cartListProvider;

  @override
  State<CartListViewWidget> createState() => _CartListViewWidgetState();
}

class _CartListViewWidgetState extends State<CartListViewWidget> {
  late Future<List<ItemCart>> futureCart;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCart = widget.MarketplaceName == 'Tokopedia'
        ? getCartTokopedia()
        : getCartBukalapak();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###', 'en_US');

    return FutureBuilder<List<ItemCart>>(
        future: futureCart,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFF9900)),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${widget.MarketplaceName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Container(
                      // height: 270,
                      constraints:
                          BoxConstraints(minHeight: 150, maxHeight: 270),
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, indexItem) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        onChanged: (index) {
                                          widget.cartListProvider
                                              .changeItemCheckedValue(
                                                  snapshot.data, indexItem);
                                        },
                                        value:
                                            snapshot.data![indexItem].checked,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          snapshot.data![indexItem].image,
                                          fit: BoxFit.cover,
                                        ),
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
                                              snapshot
                                                  .data![indexItem].itemName,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'RP. ${formatter.format(snapshot.data![indexItem].itemPrice)}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              snapshot
                                                  .data![indexItem].itemStore,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ClipOval(
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  // color: Colors.amber,

                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color
                                                                .fromARGB(255,
                                                                202, 202, 202)
                                                            .withOpacity(0.4),
                                                        offset: Offset(0, -20),
                                                        blurRadius: 1)
                                                  ]),
                                              child: TextButton(
                                                  onPressed: () {
                                                    widget.cartListProvider
                                                        .SubstractItemTotalValue(
                                                            snapshot.data,
                                                            indexItem);
                                                  },
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all(CircleBorder(
                                                              side: BorderSide(
                                                                  width: 2,
                                                                  color: Color(
                                                                      0xFFFF9900))))),
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xFFFF9900)),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          ClipRect(
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  // color: Colors.amber,

                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color
                                                                .fromARGB(255,
                                                                202, 202, 202)
                                                            .withOpacity(0.4),
                                                        offset: Offset(0, -20),
                                                        blurRadius: 1)
                                                  ]),
                                              child: TextButton(
                                                  onPressed: () {},
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              side: BorderSide(
                                                                  width: 2,
                                                                  color: Color(
                                                                      0xFFFF9900))))),
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      snapshot.data![indexItem]
                                                          .itemTotal
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xFFFF9900)),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          ClipOval(
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  // color: Colors.amber,

                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color
                                                                .fromARGB(255,
                                                                202, 202, 202)
                                                            .withOpacity(0.4),
                                                        offset: Offset(0, -20),
                                                        blurRadius: 1)
                                                  ]),
                                              child: TextButton(
                                                  onPressed: () {
                                                    widget.cartListProvider
                                                        .addItemTotalValue(
                                                            snapshot.data,
                                                            indexItem);
                                                  },
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all(CircleBorder(
                                                              side: BorderSide(
                                                                  width: 2,
                                                                  color: Color(
                                                                      0xFFFF9900))))),
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      "+",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xFFFF9900)),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return CircularProgressIndicator();
        });
  }
}

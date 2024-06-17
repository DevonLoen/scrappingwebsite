import "dart:js";

import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:scrappingwebsite/devon/home_screen.dart";
import "package:scrappingwebsite/devon/profile_screen.dart";
import "package:scrappingwebsite/tian/cartListProvider.dart";

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    int _selectedindex = 0;
    final cartListProvider = Provider.of<CartListProvider>(context);
    final BukalapakCartList =
        Provider.of<CartListProvider>(context, listen: false).BukalapakCart;
    final LazadaCartList =
        Provider.of<CartListProvider>(context, listen: false).LazadaCart;
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color(0xFFFF9900),
        index: _selectedindex,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(IconData(0xe59c, fontFamily: 'MaterialIcons')),
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.person_outline, size: 30),
        ],
        onTap: (index) {
          // _selectedindex = 1;
          //Handle button tap
          if (index == 0) {
            //           Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Signup_screen()),
            // );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home_screen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile_screen()),
            );
          }
        },
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
                  MarketplaceName: "Lazada",
                  cartList: LazadaCartList,
                  cartListProvider: cartListProvider),
              SizedBox(
                height: 20,
              ),
              CartListViewWidget(
                  MarketplaceName: 'Bukalapak',
                  cartList: BukalapakCartList,
                  cartListProvider: cartListProvider),
              SizedBox(
                height: 20,
              ),
              CartListViewWidget(
                  MarketplaceName: "Tokopedia",
                  cartList: TokopediaCartList,
                  cartListProvider: cartListProvider),
            ],
          ),
        ),
      ),
    );
  }
}

class CartListViewWidget extends StatelessWidget {
  const CartListViewWidget({
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
              // height: 270,
              constraints: BoxConstraints(minHeight: 150, maxHeight: 270),
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartList.length,
                  itemBuilder: ((context, indexItem) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                onChanged: (index) {
                                  cartListProvider.changeItemCheckedValue(
                                      cartList, indexItem);
                                },
                                value: cartList[indexItem].checked,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(cartList[indexItem].image),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartList[indexItem].itemName),
                                    Text(cartList[indexItem].itemPrice),
                                    Text(cartList[indexItem].itemStore),
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
                                                color: const Color.fromARGB(
                                                        255, 202, 202, 202)
                                                    .withOpacity(0.4),
                                                offset: Offset(0, -20),
                                                blurRadius: 1)
                                          ]),
                                      child: TextButton(
                                          onPressed: () {
                                            cartListProvider
                                                .SubstractItemTotalValue(
                                                    cartList, indexItem);
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  CircleBorder(
                                                      side: BorderSide(
                                                          width: 2,
                                                          color: Color(
                                                              0xFFFF9900))))),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFF9900)),
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
                                                color: const Color.fromARGB(
                                                        255, 202, 202, 202)
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
                                                          BorderRadius.circular(
                                                              5),
                                                      side: BorderSide(
                                                          width: 2,
                                                          color: Color(
                                                              0xFFFF9900))))),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              cartList[indexItem]
                                                  .itemTotal
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFF9900)),
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
                                                color: const Color.fromARGB(
                                                        255, 202, 202, 202)
                                                    .withOpacity(0.4),
                                                offset: Offset(0, -20),
                                                blurRadius: 1)
                                          ]),
                                      child: TextButton(
                                          onPressed: () {
                                            cartListProvider.addItemTotalValue(
                                                cartList, indexItem);
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  CircleBorder(
                                                      side: BorderSide(
                                                          width: 2,
                                                          color: Color(
                                                              0xFFFF9900))))),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFF9900)),
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
  }
}

import "dart:js";

import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";
import "package:scrappingwebsite/pembayaran_popup.dart";
import "package:scrappingwebsite/tian/CartPage.dart";
import "package:scrappingwebsite/tian/cartListProvider.dart";
import 'package:jwt_decode/jwt_decode.dart';
import "package:shared_preferences/shared_preferences.dart";

class PurchasePage extends StatefulWidget {
  const PurchasePage({
    super.key,
  });
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
  int totalPrice = 0;
  String? selectedPayment;
  late Map<String, dynamic> decodedToken;
  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  void fetchToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    decodedToken = Jwt.parseJwt(token!);

    // Use decodedToken data as needed
    print(decodedToken); // Example: Print decoded token data
  }

  Widget buildPaymentOption(String paymentMethod, String imgurl) {
    bool isSelected = selectedPayment == paymentMethod;

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedPayment = null; // Deselect if already selected
          } else {
            selectedPayment = paymentMethod; // Select the tapped item
          }
        });
        print(paymentMethod);
      },
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.transparent,
            width: 1,
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Image.network(
            imgurl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

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
    print('tes');
    print(CheckedCartList);
    print(CheckedCartListTes);
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
              totalPrice: totalPrice,
              MarketplaceName: "Order Summary",
              cartList: CheckedCartListTes,
              cartListProvider: cartListProvider,
              deliveryPrice: deliveryPrice,
              price: 0),
          Container(
              margin: EdgeInsets.all(10), child: Text('Metode Pembayaran')),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  width: 160,
                  height: 240,
                  child: Column(
                    children: [
                      Text(
                        'Uang Elektronik',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      buildPaymentOption('ovo',
                          'data:image/jpeg;base64,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'),
                      buildPaymentOption('dana',
                          'data:image/png;base64,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'),
                      buildPaymentOption('gopay',
                          'data:image/png;base64,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'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  width: 160,
                  height: 240,
                  child: Column(
                    children: [
                      Text(
                        'Bank',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      buildPaymentOption('bca',
                          'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBhUIBwgVFRUWGR0ZFRUXGR4eGRoeIBcYGR4gGhgfKCohJB4pHCAjIzEhJSo3Li8vICEzOTMsNyo5LisBCgoKDg0OGxAQGzclHyM3Li0tLTUvNS8tLy8tMDctKy4tLy0rLzYtLTAtLS4tKy0tLy0vLS0vLS0rLS0tKy0tNf/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAABQYDBAcIAQL/xABEEAACAQMCAwQGBQYOAwAAAAAAAQIDBBEFIQYSURMxQWEHIjJxgZEUQlJioRUjM3KCkxYXJFWDkqKjsbPB0dLwQ1NU/8QAGQEBAAMBAQAAAAAAAAAAAAAAAAECBAMF/8QALhEBAAIBAwIDBAsAAAAAAAAAAAECEQMEMRIhE0FRImGB8AUUIzJCUpGhwdHx/9oADAMBAAIRAxEAPwDsgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaF5qLo3P0S1tpVanKpOMWkoxbaUpyk9k3FpYy3h7bExGUTOG+CMjS1mvvWuqVJfZpwc5L+knhP92Qep6zpel3P0XUOL66mnvGMKUuXykoUXj9ovXTm3aETaI5W8ELYxuLu0VzpnETqxl7Mp06U4+782qb26ZyZ/pOq2z/AJTYRqx+1RliXm3SnjC902/LrE0+f9OpJgw2lzSvLWNzbyzGaTWU08Pqnun1T3RmKLANLU9V0/SqanqV3CmpPEXJ4y+/Yj/4Y8OfzzS+ZaKWnvEKzascynQQtDi3h6vU5Kes0cvuzNR/xwTKaksxewmsxzCYtE8PoB88MlUvoNaeoWNN8s72mn0c4r/UyW1xQu6Cr2taM4S3jKLTi/c1sTiTLKDXvb20sKPbX11CnHOOaclFZ6ZfiaP8J9A/ny2/fQ/3Jitp4hE2iOZSwIunxHoVWoqdLWbdttJJVYNtt4SSz3tkoRNZjkiYngABCQAAAAAAAAAACM0X892t9L/yVZJZ+xTfZRx5Plc1+uyQrVOyouq/qpv5LJB/Sp6HwOrpLmlSt4vfxkqa78fe3fxL1jMYjzVmW/xBc1rLQa91a+3ClOUfeoNr8Tzw228ybbe7b3bfi2+pJy4i1ud39Llq1bnf33y+7k9jl+7jHka9WgriMa9pSxzy5HTXdGb7lH7svDpiS8Mv19vo+DE583n62p4nC5eh66uI61Vs4t9nKnzyXgpRlCKfvak154XQ60eeHqFawhKz0u6lCOfzlSDadVrO/Mt+Rb8sem73e149FfEOoXGpS0m9uJVIODnBzblKLUoprL3w0+5vbCx3mbdbebZ1IdtDViMUXvSsW1/cWCxhSVaC6Rq8zf8AexqP4olCMnJQ4lhFL26E8/sVaWP8xkjOEakHTktmsP47GC3q1w4dx/rv5c4glKjPNKlmnS6PD9aX7UvwUStNqPeze12dtPWqzsKMYU1UkqcY9yjF8qwvNLPxJrgLW9K0K9q3OrUZS5oqMOWKljduWctY7o/ie5H2enHTHHk8ufav3lV1hrYvnop1u6o6wtHnUbpVIycYv6korm9Xomk8rrh++ucW6pa6zr072wtezg0klhJywsczS2y/8Eia0ywu+EtAnxBdxcK9VdlbQftR5t5TkvBqKeE/j3lNbF9PEx3niPetp5i+Y4ha+NOPoaRWlp+kRjOstpzlvCm+mPrS8u5eOe45fqesalq0+bUr6dTyk/V+EF6q+CNFvxb97f8AudF4U9G6vLSN7rtWUVJJxow2lh93PJ92fsrddfBViult65nn91ptfWnEOcqMV3RRPcG1dY/LkLTQ7uVOVSXrY3hhbylOD2eF138E9zpdf0bcOVKXJTo1IP7Uakm18JZX4GbhDhC34XdavVuVOUtlUa5eWmt8PfZ53bXSPcUvvNO1Jxz71q7a8WhQfSXxB+V9a+hW880qDcV0lPulL4eyvdLqU83tbubS71WpW022jTpZxThFYXKtk8dX3v34MTsqq0xag/ZdR015tRUn8k18/I06cRSkRw43mbWmX3SZKGrUZvwq038pxPRz7zzZbTVO5jUfhJP5NM9Jy7zD9Ic1+LTtPMAB5zYAAAAAAAAAADFc03VtpUl9aLXzTRX9UvcejyV7RpqWbVNKSysSprOV4pJ7llIvQ0oWtTT6iT7KpKGMbcj9emseK7OUV70y9Jx39FbRns4J/I6vc5Un5+vD5+3FfCb95JaLQlRlU7VL1OSrFrdNwVXlcX4rLfxWHusHUrjh7g6jcy+kafSi44cm1JU1lxSWfYT9aPq9+62NavwXpjlKnp9/GnCbklD2sOUeVqLcs45oyfL1cj0Z3dZjHdjjb2icuR07aFOkp3VblTWYxS5ptbYeMpJNdWm1hpNPJc/RXdU48Tu3tbbClSnzSk+ae0oNbpJKPhhLvay3hYuFDhThanHs7ynSq1JTalOUvWc288qSltjKSivImNA03RrO27fRLWEYz+tFPLw33t+ts87MprbqtqTGJ/hbT29otE5fqcVU4ljJfUoTz/SVKeP8tjiXUPyVoFe+T3hTly/rNYj/AGmj5pWLi/uL5Yw5qjFrxjSyn8qsqi+BV/S/f9hoVOxi96tTLX3YLmf9pxMunTr1K1+fWXe9umky5HFYjhF30H0c3OsaPT1F6nGn2i5lB03LCy0vW5l3rfu8SkEktf1hWis46pVVNR5VBTaXKljG3hjbB7OrF5j2Jw86k1ifajLRkpULhqFTeMtpRfins4y96ymWrjDXa+ucOWNW4frZrKp5zh2UU/jGWf2iq21vWuriNta0nOcniMYrLb8kdI17gu4tuAqVGjHnrUJOrNR3zz+2o9cJR9/J5nPVtSt69XK9ItNbY4c2oyhCtGdSGUmm11SeWvij0jb3FG6oRuLeopRklKMl3NPdNHmtNNZRJ6XxDrGkU+z03UZwj38uzj8IyTS+CK7nbzqxGJ4W0dXw85ehSjelTXfoOjrTLefr1/ax4U17X9Z+r7uboU/QtU1jibV422r6tN0IJ1bjujDs4LMudRSTT2i0+pB8SavU13WqmoVNlJ4gvswW0V8t35tmbR2k11I6pzjv/TrqbjNO3mjCd1bWrS74dttJtLWUOxy5SbXrykvWaS6yy/dgx8N8NahxJVnT09wXZpOTm2lu2ktk93h/JmXiThPUeG6MKuoVKTU21HklJ7pZ3zFG61qTeKzPeGaItFc47ICo8Qb8j0wnzLm6nmar+jfuPSlpPntYT6xT/BGL6Q/D8WjaefwZgAea2gAAAAAAAAAA+Ghd6fWldu8sLvs6jioyUoqdOSTbjzR2llZe8ZLv3ztjfPpMTgmMqzf6bWrdpK90jndTHNK3qrLxHlT7Oryxi1hPZv2Y9+D5G2soXHa3FldfpHVUXSk0nzyqJZp5TSnJtZb8OhZwX8SVOhWKdFU7h3NnZ3km6nPhKEMZlJtPtXF8rct0t9ljfOduzstRp0uwtYUraGc7N1aj2SyspQjLZfbXzJwETdMVYLK1p2VpG2o5xFYy92+rb8W3u31bIvX+FtM4grRq6lCbcE1Hlm0ll5ey/wC7ImwRF7VnMT3TNYmMSp/8W3Df/oqfvJBejbhvP6Cp+8kXAHTx9X80/qp4NPSEZo+gaVosMaZZRg3s5buT983mTXlkkwDlMzM5leIiOFP4i9H2lavWdzbSdCo924JOEn1lDr+q1nxyVp+im+5sR1anjrySz8s/6nVQd67rVrGIlztoUtOZhStJ9HttZaPWsa+oTbr8qqVKaUHyxeeVc3Ns339e4wfxV6L/APfc/wBan/wL4CPrGrnOTwaeiI4a4es+G7KVrYynJSlzSlNpybwl4JLCS6dTFxTwza8TUIUryvUgoNyXJy5eVjfmTJwHPxLdXVnuv0Rjpx2UF+inR2sPUbj50/8AgXq3pKhQjRTzypLL79ljcyAm+re/3pyitK14gABzXAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/2Q=='),
                      buildPaymentOption('bri',
                          'data:image/png;base64,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'),
                      buildPaymentOption('mandiri',
                          'data:image/png;base64,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'),
                      buildPaymentOption('bni',
                          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAR4AAACwCAMAAADudvHOAAAA8FBMVEX////paT44eIMydoGIqK4pcHtliY8scn7V19jB0dT67ernXSp4kZfh6OkfbHnSubT1zcPM2dvw7OzHl4rDyMrrYzR8oKeXs7jpZTf7//+bqKtZgYgVanf25eHr8PLsjXGtwsbnVBPmWSHsiWrPeWBDcXphjZaqr7BwmKD39fVJgYvn7O2ElZmPparunIXU0dHEgG7aXjHVakfUYz3Aw8TrgmHYiHPpcUnErablwrmlrK7yt6j0xLe8i37lrJ68loz22dHAubjpTwjXysi4f3C2vb/wpI+2q6jRj37qeVfNfmrMcVbt4N3RtK/lppbftqunu8eHAAAEhklEQVR4nO3Z21bbRhQG4JGEkECxXRwLS9j4IA5FGDAYl3PAaeI2NDR9/7fp3nOwxy7kKqGLWf93E0kea6E/M3tmZCEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC0dc061ErVoFOxdebfVBdy617l2gZZ25CfymN98mbV+gkrdoTId4vE0v9FtYj32lXLvnne8lc+bR9YNyu3qGn7cMDH9SP+Wvu4/rrP84PVEo9lJxxP5lkSHY8Y+iQKWeD7QbtpvjuN6INqz77dDV3Sva5sBX7YFG+biadL8ZzqeLLkbDQ6L0w8YjXwo804bjTG7xYCiUMOrj2wblcPoxXra9W1V3qMn8XE8xsdv09Vt7kYDvK8E5emzTuKR3eDMfUfP9QFSMUTHFq3cy2e4ZnqMZd0fCWjSq+X21jxiBuKJOypYxWPH67Mm7oWT36luky6TVFxPMm12L69vdu22tjx1PeoDm2qY46He5MVgmvxiPyDzCe5oyl8lHnpSX7P81baXZ81sePhhw6seFpcraPZOHQuHjHYTU3xeUi9tLwvVDXqT0wLO56Si7Ge2ymeaMr5RPumqXvxiPicZ6xsm4/Sk85/JvaFeJqRH5qlDsVT3RhzAarOxp578YiPHE96y4Xo98mn5Hvx9CiRllk5y3jElsynoi65Fs811Zz8gSPJ6Kzzeb32bDzBfnOT7NNw2pp9l+IJaZzJ8qMXg67FU+tvcypUfhLqPiIXz/ceKr+M5yl/xawDVe+hXQeXHzXinIsn8ej/vfKV8kllB6iMsufi8SmcMIx41RyZbYXuPWI8X0u7F0/Kc1aDVofpCV/I9dp5aXAdxLyrmB7vcRTtnrxu4hFbMh/uVO7F4yV/0L9/piaQWHefxdKslzq0EZeVWHY0Pbhotl8N9ObCwXjkkpDLc5bJpx6fZS/HI8RRZLYVs3hoLR2ozYWL8XjJhMrzaXH5lMul8sfz9DvxzLcVs8FFkYZqc+FkPJ5HscRfyvyikHut+PQsyYoX4lHzvGw2j0eWnyDouBlP9kiH+fpjmmUTvpoPH/7anZg2S/HQ6FIvMex4Sn4VFO2XTsbjJTxrXRV6b8ry+UvkpXh4U2riqc5eJT/J8nPsuxhP+sivhNXmvehO+INJ9860WYxnwMNILgIX4lHlJ3IxnuKizL9NeHUoN6fJZbd7mbxUe1Yjs2e3B5fQqx8H4ynu83xHrp4b+t1hlr00c1UOeF5XZ0vxlKuRg/FkSU08eZmX7gheHabm54rlLSnbPKRtV1Cdvw6r2j9jydWPY/EU3pO4lpkUvCdtfP46WoqnPJxtSTmc0J/qD6ah9RaRDSmfeTy0k1/8lecN+puK8rd+Ksn3g/ngIpFns9rTbIdzUWtqftirBGEULnQfEbeiWTwbYRAEfuWVnuMneSrFpy/vtX/4Su2DPtNv48txw2L9qHWzxXoLt6sftXU8cUt54/n8aOPe//0XAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgEP+BaxyX3ywkyVTAAAAAElFTkSuQmCC'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              List.generate(CheckedCartListTes.length, (indexItem) {
                totalPrice += (CheckedCartListTes[indexItem].itemPrice as int) *
                    CheckedCartListTes[indexItem].itemTotal as int;
              });
              return Pembayaran_popup(
                cartList: CheckedCartListTes,
                name:
                    '${decodedToken['first_name']} ${decodedToken['last_name']}',
                number: '${decodedToken['phone_number']}',
                rekening: '83759656658',
                item: "Product",
                total: '${(totalPrice + deliveryPrice + 5000)}',
                alamat: "Jl. M. H. Thamrin, Nomor 100A",
                metode_pembayaran: selectedPayment!,
                delivery_options: deliveryOptions[selectedDeliveryOptions!]
                    ['type'],
              );
            },
          );
        },
        child: Container(
          height: 30,
          color: Colors.orange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payment_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'BAYAR',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartOrderWidget extends StatelessWidget {
  final int price;
  CartOrderWidget(
      {super.key,
      required this.MarketplaceName,
      required this.cartList,
      required this.cartListProvider,
      required this.deliveryPrice,
      required this.price,
      required this.totalPrice});
  final int deliveryPrice;
  final String MarketplaceName;
  final List<dynamic> cartList;
  final CartListProvider cartListProvider;

  int totalPrice;
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###', 'en_US');
    print(price);
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
                        this.totalPrice +=
                            (cartList[indexItem].itemPrice as int) *
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Subtotal Items",
                        //       style: TextStyle(fontSize: 14),
                        //     ),
                        //     Text('RP. ${price}',
                        //         style: TextStyle(fontSize: 14)),
                        //   ],
                        // ),
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
                          'RP. ${formatter.format(price + totalPrice + deliveryPrice + 5000)}',
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

// class Pembayaran_widget extends StatefulWidget {
//   const Pembayaran_widget({Key? key}) : super(key: key);

//   @override
//   _Pembayaran_widgetState createState() => _Pembayaran_widgetState();
// }

// class _Pembayaran_widgetState extends State<Pembayaran_widget> {
//   String? selectedPayment;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               border: Border.all(
//                 color: Colors.amber,
//                 width: 1,
//               ),
//             ),
//             width: 160,
//             height: 240,
//             child: Column(
//               children: [
//                 Text(
//                   'Uang Elektronik',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//                 buildPaymentOption('ovo'),
//                 buildPaymentOption('dana'),
//                 buildPaymentOption('gopay'),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               border: Border.all(
//                 color: Colors.amber,
//                 width: 1,
//               ),
//             ),
//             width: 160,
//             height: 240,
//             child: Column(
//               children: [
//                 Text(
//                   'Bank',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//                 buildPaymentOption('bca'),
//                 buildPaymentOption('bri'),
//                 buildPaymentOption('mandiri'),
//                 buildPaymentOption('bni'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Pembayaran_widget extends StatelessWidget {
//   const Pembayaran_widget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
//             decoration: BoxDecoration(
//               // color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                   bottomLeft: Radius.circular(25),
//                   bottomRight: Radius.circular(25)),
//               border: Border.all(
//                 color: Colors.amber, // Warna border
//                 width: 1, // Lebar border
//               ),
//             ),
//             width: 160,
//             height: 190,
//             // color: Colors.amber,
//             child: Column(
//               children: [
//                 Text(
//                   'Uang Elektronik',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     print('ovo');
//                   },
//                   child: Container(
//                     // color: Colors.red,
//                     width: double.infinity,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       // color: Colors.red,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                         bottomLeft: Radius.circular(15),
//                         bottomRight: Radius.circular(15),
//                       ),
//                       border: Border.all(
//                         color: Colors.amber, // Warna border
//                         width: 1, // Lebar border
//                       ),
//                     ),
//                     margin: EdgeInsets.symmetric(vertical: 5),

//                     child: Center(child: Text('ovo')),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     print('dana');
//                   },
//                   child: Container(
//                     // color: Colors.red,
//                     width: double.infinity,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       // color: Colors.red,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                         bottomLeft: Radius.circular(15),
//                         bottomRight: Radius.circular(15),
//                       ),
//                       border: Border.all(
//                         color: Colors.amber, // Warna border
//                         width: 1, // Lebar border
//                       ),
//                     ),
//                     margin: EdgeInsets.symmetric(vertical: 5),

//                     child: Center(child: Text('dana')),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     print('gopay');
//                   },
//                   child: Container(
//                     // color: Colors.red,
//                     width: double.infinity,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       // color: Colors.red,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                         bottomLeft: Radius.circular(15),
//                         bottomRight: Radius.circular(15),
//                       ),
//                       border: Border.all(
//                         color: Colors.amber, // Warna border
//                         width: 1, // Lebar border
//                       ),
//                     ),
//                     margin: EdgeInsets.symmetric(vertical: 5),

//                     child: Center(child: Text('gopay')),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // bank
//           Container(
//             padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
//             decoration: BoxDecoration(
//               // color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(25),
//                 topRight: Radius.circular(25),
//                 bottomLeft: Radius.circular(25),
//                 bottomRight: Radius.circular(25),
//               ),
//               border: Border.all(
//                 color: Colors.amber, // Warna border
//                 width: 1, // Lebar border
//               ),
//             ),
//             width: 160,
//             height: 240,
//             // color: Colors.amber,
//             child: Column(
//               children: [
//                 Text(
//                   'Bank',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     print('gopay');
//                   },
//                   child: Container(
//                     // color: Colors.red,
//                     width: double.infinity,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       // color: Colors.red,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                         bottomLeft: Radius.circular(15),
//                         bottomRight: Radius.circular(15),
//                       ),
//                       border: Border.all(
//                         color: Colors.amber, // Warna border
//                         width: 1, // Lebar border
//                       ),
//                     ),
//                     margin: EdgeInsets.symmetric(vertical: 5),

//                     child: Center(child: Text('bca')),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     print('bca');
//                   },
//                   child: Container(
//                     // color: Colors.red,
//                     width: double.infinity,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       // color: Colors.red,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                         bottomLeft: Radius.circular(15),
//                         bottomRight: Radius.circular(15),
//                       ),
//                       border: Border.all(
//                         color: Colors.amber, // Warna border
//                         width: 1, // Lebar border
//                       ),
//                     ),
//                     margin: EdgeInsets.symmetric(vertical: 5),

//                     child: Center(child: Text('bri')),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     print('bri');
//                   },
//                   child: Container(
//                     // color: Colors.red,
//                     width: double.infinity,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       // color: Colors.red,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                         bottomLeft: Radius.circular(15),
//                         bottomRight: Radius.circular(15),
//                       ),
//                       border: Border.all(
//                         color: Colors.amber, // Warna border
//                         width: 1, // Lebar border
//                       ),
//                     ),
//                     margin: EdgeInsets.symmetric(vertical: 5),

//                     child: Center(child: Text('mandiri')),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     print('bni');
//                   },
//                   child: Container(
//                     // color: Colors.red,
//                     width: double.infinity,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       // color: Colors.red,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                         bottomLeft: Radius.circular(15),
//                         bottomRight: Radius.circular(15),
//                       ),
//                       border: Border.all(
//                         color: Colors.amber, // Warna border
//                         width: 1, // Lebar border
//                       ),
//                     ),
//                     margin: EdgeInsets.symmetric(vertical: 5),

//                     child: Center(child: Text('bni')),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:scrappingwebsite/tian/colorPickerDetailPageWidget.dart";

class DetailPageWidget extends StatefulWidget {
  const DetailPageWidget({super.key});

  @override
  State<DetailPageWidget> createState() => _DetailPageWidgetState();
}

class _DetailPageWidgetState extends State<DetailPageWidget> {
  final List DeskripsiList = ["ngetes", 'ngetes', 'aja'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFF9900),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "KERANJANG",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFFF9900)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius:
                        BorderRadius.circular(10), // Adjust the radius here
                  ))),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "BELI LANGSUNG",
                style: TextStyle(color: Color(0xFFFF9900)),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 255, 255)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Adjust the radius here
                  ))),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: const Color(0xFFFF9900),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
        height: 50,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width - 75),
                child: const Column(children: [
                  Image(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.fitWidth,
                  ),
                  // color: Colors.amber,

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Baju Oversized",
                    style: TextStyle(fontSize: 24),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rp. 250.000 ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      Icon(IconData(0xe5f9, fontFamily: 'MaterialIcons')),
                      Icon(IconData(0xe5f9, fontFamily: 'MaterialIcons')),
                      Icon(IconData(0xe5f9, fontFamily: 'MaterialIcons')),
                      Icon(IconData(0xe5f9, fontFamily: 'MaterialIcons')),
                      Icon(IconData(0xe5f9, fontFamily: 'MaterialIcons')),
                    ],
                  )
                ]),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Colors"),
                SizedBox(
                  height: 5,
                ),
                DetailPickerWidget(
                  list: [
                    Colors.red,
                    Colors.green,
                    Colors.blue,
                    // Add more colors as needed
                  ],
                  colorPick: true,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Ukuran"),
                SizedBox(
                  height: 5,
                ),
                DetailPickerWidget(
                  list: [
                    'S',
                    'M', 'L', "XL", "XXL"
                    // Add more colors as needed
                  ],
                  colorPick: false,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Deskripsi Produk"),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      DeskripsiList.length,
                      (index) => RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Text(
                                '• ${DeskripsiList[index]}',
                                style: TextStyle(fontSize: 15),
                              ), // Bullet character
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          // Add more items as needed
        ],
      ),
    );
  }
}

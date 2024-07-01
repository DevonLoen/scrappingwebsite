// import 'dart:ffi';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:scrappingwebsite/filterpopup.dart';
import 'package:scrappingwebsite/sortpopup.dart';
import 'package:scrappingwebsite/tian/detailPageScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item_Screen extends StatefulWidget {
  const Item_Screen({super.key});

  @override
  State<Item_Screen> createState() => _Item_ScreenState();
}

class _Item_ScreenState extends State<Item_Screen> {
  int _selectedindex = 0;

  String selectedSort = 'termurah';
  final SearchController controller = SearchController();

  List<String> searchhistory = [];
  void sorttermurah(List<Map<String, dynamic>> data) {
    data.sort((a, b) {
      try {
        // Extracting and cleaning price strings
        String priceStringA =
            a['harga']!.replaceAll('Rp ', '').replaceAll(',', '');
        String priceStringB =
            b['harga']!.replaceAll('Rp ', '').replaceAll(',', '');

        // Parsing prices into integers
        int priceA = int.parse(priceStringA);
        int priceB = int.parse(priceStringB);

        // Sorting in ascending order based on price (from lowest to highest)
        return priceA.compareTo(priceB);
      } catch (e) {
        print('Error parsing price: $e');
        return 0; // or handle error as needed
      }
    });
  }

  void sorttermahal(List<Map<String, dynamic>> data) {
    data.sort((a, b) {
      try {
        // Extracting and cleaning price strings
        String priceStringA =
            a['harga']!.replaceAll('Rp ', '').replaceAll(',', '');
        String priceStringB =
            b['harga']!.replaceAll('Rp ', '').replaceAll(',', '');

        // Parsing prices into integers
        int priceA = int.parse(priceStringA);
        int priceB = int.parse(priceStringB);

        // Sorting in descending order based on price
        return priceB.compareTo(priceA);
      } catch (e) {
        print('Error parsing price: $e');
        return 0; // or handle error as needed
      }
    });
  }

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Product 1',
      'price': 'Rp 100,000',
      'rating': 4.5,
      'city': 'Jakarta',
      'source': 'Tokopedia'
    },
    {
      'name': 'Product 2',
      'price': 'Rp 200,000',
      'rating': 4.0,
      'city': 'Bandung',
      'source': 'Bukalapak'
    },
    {
      'name': 'Product 3',
      'price': 'Rp 300,000',
      'rating': 4.8,
      'city': 'Surabaya',
      'source': 'Bukalapak'
    },
    {
      'name': 'Product 4',
      'price': 'Rp 400,000',
      'rating': 3.5,
      'city': 'Medan',
      'source': 'Bukalapak'
    },
    {
      'name': 'Product 5',
      'price': 'Rp 500,000',
      'rating': 4.9,
      'city': 'Yogyakarta',
      'source': 'Tokopedia'
    },
  ];

  void mengurutkan() {
    if (selectedSort == 'termurah') {
      print('ini');
      sorttermurah(products);
      // sorttermurah(data2);
    } else {
      sorttermahal(products);
      // sorttermahal(data2);
    }
    print('mengurutkan');
  }

  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    // Now you can use prefs throughout your widget!
  }

  @override
  Widget build(BuildContext context) {
    final forNullMap = {};
    final productsResult = ModalRoute.of(context)!.settings.arguments == null
        ? forNullMap
        : ModalRoute.of(context)!.settings.arguments
            as Map<String, List<Map<String, dynamic>>>;
    print('productsResult');
    print(productsResult);
    print(productsResult == forNullMap);
    final bukalapakProducts = productsResult == forNullMap
        ? []
        : productsResult!['bukalapak'] as List<Map<String, dynamic>>;
    final tokopediaProducts = productsResult == forNullMap
        ? []
        : productsResult!['tokopedia'] as List<Map<String, dynamic>>;
    print('bukalapakProductTes.runtimeType');
    print(tokopediaProducts);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('product page'),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.orange,
            automaticallyImplyLeading: false,
            expandedHeight: 75.0,
            pinned: false,
            snap: true,
            floating: true,
            flexibleSpace: SizedBox(
              height: 120, // Tinggi AppBar diatur disini
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    SearchAnchor(
                      // dividerColor: Colors.amber,
                      viewSurfaceTintColor: Colors.white,
                      // MENGUBAH BACKGROUND COLOR
                      isFullScreen: true,
                      // viewBackgroundColor: Colors.white,

                      searchController: controller,
                      viewHintText: 'Search in Products',
                      viewTrailing: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              searchhistory.add(controller.text);
                              searchhistory =
                                  searchhistory.reversed.toSet().toList();
                              controller.closeView(controller.text);
                            });
                          },
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.clear();
                            },
                            icon: const Icon(Icons.clear))
                      ],
                      builder: (context, controller) {
                        return SearchBar(
                          // backgroundColor:
                          //     MaterialStateProperty.all<Color>(
                          //   const Color(0xFF42A5F5),
                          // ),
                          constraints: BoxConstraints(
                            minWidth: 300,
                            minHeight: 40,
                            maxWidth: 300,
                            maxHeight: 40,
                          ),
                          side: MaterialStateProperty.all(BorderSide(
                            color: Color(0xFFCACACA),
                            width: 2.0,
                            style: BorderStyle.solid,
                          )),
                          // backgroundColor: MaterialStateProperty.all(Colors.white),

                          controller: controller,
                          // leading: IconButton(
                          //   onPressed: () {},
                          //   icon: const Icon(Icons.search),
                          // ),
                          //untuk menambahkan icon di samping kanan search bar
                          /*
                              trailing: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.mic),
                                ),
                              ],
                              */
                          hintText: 'Search Your Product',
                          hintStyle:
                              MaterialStateProperty.resolveWith<TextStyle?>(
                                  (Set<MaterialState> states) {
                            return TextStyle(
                                color: Color(
                                    0xFFCACACA)); // Change 'Colors.red' to any color you desire
                          }),
                          onTap: () => controller.openView(),
                        );
                      },
                      suggestionsBuilder: (context, controller) {
                        return [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Recent History Searches'),
                          ),
                          Wrap(
                            children:
                                List.generate(searchhistory.length, (index) {
                              final item = searchhistory[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ChoiceChip(
                                  side: BorderSide(color: Colors.white),
                                  label: Text(item),
                                  selected: item == controller.text,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24.0))),
                                  onSelected: (value) {
                                    controller.text = item;
                                    controller.closeView(item);
                                  },
                                ),
                              );
                            }),
                          ),
                          if (controller.text.isNotEmpty) ...[
                            const Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              // padding: EdgeInsets.only(bottom: 10000),
                              // scrollDirection: acxis,
                              itemCount: products.length,
                              itemBuilder: (context, index) => Product(
                                  context: context,
                                  product: products,
                                  index: index,
                                  MarketplaceName: ""),
                            ),
                          ]
                        ];
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              // color: Colors.blue,
              decoration: BoxDecoration(
                color: Color(0xFFFF9900),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(150),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFFFB03A), // Warna bayangan
                      spreadRadius: 12 // Jangkauan bayangan
                      // blurRadius: 10, // Jarak blur bayangan
                      // offset: Offset(4, 4), // Offset bayangan (x, y)
                      ),
                ],
              ),
              width: double.infinity,
              height: 30.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Background color
                      foregroundColor: Colors.orange, // Text and icon color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4), // Padding to make the button smaller
                      textStyle: TextStyle(fontSize: 15), // Smaller text
                      minimumSize: Size(70, 25),
                    ),
                    onPressed: () async {
                      // Action when the button is pressed
                      final String? Sort = await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return SortPopup(selectedSort: selectedSort);
                        },
                      );
                      if (Sort != null) {
                        setState(() {
                          print('helo');
                          selectedSort = Sort;
                          mengurutkan();
                          print('berhasil');
                          print(products);
                        });
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Sort'),
                        SizedBox(
                            width: 2), // Reduced space between text and icons
                        Icon(Icons.arrow_upward, size: 15), // Smaller icons
                        Icon(Icons.arrow_downward, size: 15), // Smaller icons
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Tokopedia',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              // color: Colors.red,
              height: 250, // Set a fixed height for the horizontal ListView
              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal, // Set the scroll direction to horizontal
                itemCount:
                    tokopediaProducts.length, // Number of items in the list
                itemBuilder: (context, index) {
                  return Product(
                      context: context,
                      product: tokopediaProducts,
                      index: index,
                      MarketplaceName: "tokopedia");
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'BukaLapak',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              // color: Colors.red,
              height: 250, // Set a fixed height for the horizontal ListView
              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal, // Set the scroll direction to horizontal
                itemCount:
                    bukalapakProducts!.length, // Number of items in the list
                itemBuilder: (context, index) {
                  return Product(
                      context: context,
                      product: bukalapakProducts,
                      index: index,
                      MarketplaceName: "bukalapak");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product extends StatefulWidget {
  Product(
      {super.key,
      required this.context,
      required this.MarketplaceName,
      required this.product,
      required this.index});
  BuildContext context;
  List<dynamic> product;
  int index;
  String MarketplaceName;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // Now you can use prefs throughout your widget!
  }

  Future<void> _addItemToCart() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse("http://localhost:3000/api/v1/items/create"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token!, // Replace with actual token
        },
        body: jsonEncode(<String, dynamic>{
          "nama_produk": widget.product[widget.index]['nama_produk'],
          "harga": int.parse(widget.product[widget.index]['harga']
              .replaceAll(RegExp(r'[^0-9]'), '')),
          "rating": widget.product[widget.index]['rating'],
          "penjualan": widget.product[widget.index]['penjualan'],
          "lokasi": widget.product[widget.index]['lokasi'],
          "nama_toko": widget.product[widget.index]['nama_toko'],
          "image_url": widget.product[widget.index]['img'],
          "marketplace": widget.MarketplaceName,
          "status": "keranjang",
          "jumlah": 1,
        }),
      );

      print('response keranjang');
      print(response.body);

      // Dismiss loading dialog
      Navigator.of(context).pop();

      // Show success notification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil memasukkan ke keranjang"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Dismiss loading dialog
      Navigator.of(context).pop();

      // Show error notification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal memasukkan ke keranjang"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.product[widget.index]['harga']);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPageWidget(
                  rating: widget.product[widget.index]['rating'],
                  image_url: widget.product[widget.index]['img'],
                  nama_produk: widget.product[widget.index]['nama_produk'],
                  linkdetail: widget.product[widget.index]['link_detail'],
                  lokasi: widget.product[widget.index]['lokasi'],
                  marketplace: widget.MarketplaceName,
                  nama_toko: widget.product[widget.index]['nama_toko'],
                  penjualan: widget.product[widget.index]['penjualan'],
                  isToped: widget.product[widget.index]['link_detail']
                      .startsWith("https://www.tokopedia.com"),
                  harga: int.parse(
                    widget.product[widget.index]['harga']
                        .replaceAll(RegExp(r'[^0-9]'), ''),
                  ))),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        // color: Colors.red,
        width: 150,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                  fit: BoxFit.cover,
                  // height: 150,
                  // width: double.infinity,
                  '${widget.product[widget.index]['img']}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                widget.product[widget.index]['nama_produk'],
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.5),
                //     spreadRadius: 0,
                //     blurRadius: 5,
                //     offset: Offset(0, 5),
                //   ),
                // ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight:
                        Radius.circular(10)), // Optional: Rounded corners
              ),
              width: double.infinity,
              height: 50,
              // color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product[widget.index]['harga'],
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Rating ${widget.product[widget.index]['rating']}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            widget.product[widget.index]['lokasi'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: _addItemToCart,
                        icon: Icon(
                          Icons.shopping_cart_checkout_outlined,
                          color: Colors.orange,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// product(BuildContext context, List<dynamic> product, int index,
//     String MarketplaceName, prefs) {
//   try {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         margin: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.5),
//                 spreadRadius: 0,
//                 blurRadius: 5,
//                 offset: Offset(0, 5),
//               ),
//             ],
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(10),
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//                 bottomRight: Radius.circular(10))),
//         // color: Colors.red,
//         width: 150,
//         height: 300,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//               child: Image.network(
//                   fit: BoxFit.cover,
//                   // height: 150,
//                   // width: double.infinity,
//                   '${widget.product[widget.index]['img']}'),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               child: Text(
//                 widget.product[widget.index]['nama_produk'],
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 // color: Colors.white,
//                 // boxShadow: [
//                 //   BoxShadow(
//                 //     color: Colors.black.withOpacity(0.5),
//                 //     spreadRadius: 0,
//                 //     blurRadius: 5,
//                 //     offset: Offset(0, 5),
//                 //   ),
//                 // ],
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(10),
//                     bottomRight:
//                         Radius.circular(10)), // Optional: Rounded corners
//               ),
//               width: double.infinity,
//               height: 50,
//               // color: Colors.blue,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 80,
//                       // color: Colors.red,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             widget.product[widget.index]['harga'],
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             'Rating ${widget.product[widget.index]['rating']}',
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(fontSize: 10),
//                           ),
//                           Text(
//                             widget.product[widget.index]['lokasi'],
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                         onPressed: () async {
//                           final response = await http.post(
//                               Uri.parse(
//                                   "http://localhost:3000/api/v1/items/create"),
//                               headers: <String, String>{
//                                 "Authorization": prefs.getString('token')!
//                               },
//                               body: jsonEncode({
//                                 "nama_produk": widget.product[widget.index]['nama_produk'],
//                                 "harga": int.parse(product[index]['harga']
//                                     .replaceAll(RegExp(r'[^0-9]'), '')),
//                                 "rating": product[index]['rating'],
//                                 "penjualan": product[index]['penjualan'],
//                                 "lokasi": product[index]['lokasi'],
//                                 "nama_toko": product[index]['nama_toko'],
//                                 "image_url": product[index]['img'],
//                                 "marketplace": MarketplaceName,
//                                 "status": "keranjang"
//                               }));
//                           print('response keranjang');
//                           print(response);
//                         },
//                         icon: Icon(
//                           Icons.shopping_cart_checkout_outlined,
//                           color: Colors.orange,
//                         ))
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   } catch (e) {
//     print('error di itemscreen');
//     print(e);
//   }
// }

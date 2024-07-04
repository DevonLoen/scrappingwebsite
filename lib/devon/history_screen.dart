import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scrappingwebsite/devon/user_provider.dart';
// import 'package:scrappingwebsite/home_screen.dart';
// import 'package:scrappingwebsite/profile_screen.dart';
import 'package:scrappingwebsite/filterpopup.dart';
import 'package:scrappingwebsite/sortpopup.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scrappingwebsite/devon/home_screen.dart';
import 'package:scrappingwebsite/devon/profile_screen.dart';

class History_screen extends StatefulWidget {
  const History_screen({super.key});

  @override
  State<History_screen> createState() => _History_screenState();
}

class _History_screenState extends State<History_screen> {
  int _selectedindex = 0;

  String selectedSort = 'termurah';

  List<String>? selectedFilters = [
    'selesai',
    'pengiriman',
    'tiba',
    // 'beli',
    'beli',
    'batal'
  ];

  final SearchController controller = SearchController();

  List<String> searchhistory = [];
  void sorttermurah(List<Map<String, dynamic>> data) {
    try {
      data.sort((a, b) => a['item']['harga'].compareTo(b['item']['harga']));
      print('ini sudah tersort');
      print(data);
    } catch (e) {
      print('Error sorting data: $e');
    }
  }

  void sorttermahal(List<Map<String, dynamic>> data) {
    try {
      data.sort((a, b) => b['item']['harga'].compareTo(a['item']['harga']));

      print('ini sudah tersort');
      print(data);
    } catch (e) {
      print('Error sorting data: $e');
    }
  }

  // void sorttermahal(List<dynamic> products) {
  //   print('sort');
  //   products.sort((a, b) => double.parse(b['harga']
  //           .replaceAll('Rp', '')
  //           .replaceAll('.', '')
  //           .replaceAll(',', '.')
  //           .trim())
  //       .compareTo(double.parse(a['harga']
  //           .replaceAll('Rp', '')
  //           .replaceAll('.', '')
  //           .replaceAll(',', '.')
  //           .trim())));
  // }

  // void sorttermurah(List<dynamic> products) {
  //   print('sort');
  //   products.sort((a, b) => double.parse(a['harga']
  //           .replaceAll('Rp', '')
  //           .replaceAll('.', '')
  //           .replaceAll(',', '.')
  //           .trim())
  //       .compareTo(double.parse(b['harga']
  //           .replaceAll('Rp', '')
  //           .replaceAll('.', '')
  //           .replaceAll(',', '.')
  //           .trim())));
  // }

  // final List<Map<String, String>> _data = [
  //   {
  //     'imageUrl':
  //         'https://images.tokopedia.net/img/cache/300-square/VqbcmM/2021/8/5/cb0ad05c-9278-49a4-a98a-ea06ad6925b0.png',
  //     'name': 'Lipstick No 1 indonesia merdeka',
  //     'price': 'Rp 900.000',
  //     'status': 'selesai',
  //   },
  //   {
  //     'imageUrl':
  //         'https://images.tokopedia.net/img/cache/300-square/VqbcmM/2023/3/7/92ea7433-d238-4d7b-8823-d1096f79a9d9.png',
  //     'name': 'Keju Mantap sekali',
  //     'price': 'Rp 800.000',
  //     'status': 'pengiriman',
  //   },
  //   {
  //     'imageUrl':
  //         'https://images.tokopedia.net/img/cache/300-square/product-1/2019/7/5/3453155/3453155_b49ba184-3041-444a-8708-ea65fd09ca78_1280_1280',
  //     'name': 'Baju Buat Lebaran WOW cantik Sekali',
  //     'price': 'Rp 500.000',
  //     'status': 'tiba',
  //   },
  //   {
  //     'imageUrl':
  //         'https://images.tokopedia.net/img/cache/300-square/VqbcmM/2022/8/2/fec046b9-54c6-4b47-a114-2b50d41034b4.png',
  //     'name': 'Earphpone Canggih Bikin telinga pecah',
  //     'price': 'Rp 400.000',
  //     'status': 'konfirmasi',
  //   },
  //   {
  //     'imageUrl':
  //         'https://images.tokopedia.net/img/cache/200-square/VqbcmM/2023/2/17/9e48a3b6-f313-4dae-8f6e-ffcabbf0e4ba.jpg',
  //     'name': 'Dokter laser biar kena laser matammu',
  //     'price': 'Rp 200.000',
  //     'status': 'batal',
  //   },
  // ];

  void mengurutkan(List<Map<String, dynamic>> products) {
    print('asem');
    if (selectedSort == 'termurah') {
      print('termurah');
      sorttermurah(products);
    } else {
      sorttermahal(products);
    }
    print('mengurutkan');
    setState(() {});
  }

  List<Map<String, dynamic>> _data = [];
  void fetchHistory() async {
    try {
      final result = await getHistory();
      _data = result;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHistory();
    // mengurutkan(_data);
  }

  @override
  Widget build(BuildContext context) {
    try {
      mengurutkan(_data);

      return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Text("History"),
        //   backgroundColor: Color(0xFFFF9900),
        // ),
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
                        viewHintText: 'Search in History',
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
                            hintText: 'Search Your History',
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
                                itemCount: _data
                                    .where((data) => (controller.text.isEmpty ||
                                        data['item']['nama_produk']
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                controller.text.toLowerCase())))
                                    .length,
                                itemBuilder: (context, index) {
                                  final filtereddata = _data
                                      .where((data) =>
                                          (controller.text.isEmpty ||
                                              data['item']['nama_produk']
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(controller.text
                                                      .toLowerCase())))
                                      .toList();

                                  final item = filtereddata;
                                  final status = item[index]['item']['status'];
                                  final name =
                                      item[index]['item']['nama_produk'];
                                  final price = item[index]['item']['harga'];
                                  final img = item[index]['item']['image_url'];
                                  // final title = item['title'];
                                  // print(status);
                                  if (status == 'beli') {
                                    // print('eaaaaaaaaaaaaaaaa');
                                    return selesai(context, name ?? "",
                                        price ?? "", img ?? "");
                                  }
                                },
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
                        final List<String>? Filter =
                            await showDialog<List<String>>(
                          context: context,
                          builder: (BuildContext context) {
                            return FilterPopup(
                                selectedFilters: selectedFilters);
                          },
                        );

                        // Handle selected filters here
                        if (Filter != null) {
                          setState(() {
                            selectedFilters = Filter;
                          });
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Filter'),
                          SizedBox(
                              width: 2), // Reduced space between text and icons
                          Icon(Icons.filter_list, size: 15), // Smaller icons
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
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
                            selectedSort = Sort;
                            mengurutkan(_data);
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
          body: ListView.builder(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              itemCount: _data.where((data) {
                // print('data eaaa');
                // print(data);
                // print(data['item']['status']);
                return selectedFilters!.contains(data['item']['status']) &&
                    (controller.text.isEmpty ||
                        data['item']['nama_produk']
                            .toString()
                            .toLowerCase()
                            .contains(controller.text.toLowerCase()));
              }).length,
              itemBuilder: (context, index) {
                final filtereddata = _data
                    .where((data) =>
                        selectedFilters!.contains(data['item']['status']) &&
                        (controller.text.isEmpty ||
                            data['item']['nama_produk']
                                .toString()
                                .toLowerCase()
                                .contains(controller.text.toLowerCase())))
                    .toList();

                final item = filtereddata;
                final status = item[index]['item']['status'];
                final name = item[index]['item']['nama_produk'];
                final price = item[index]['item']['harga'];
                final img = item[index]['item']['image_url'];
                // final title = item['title'];
                // print(status);
                if (status == 'beli') {
                  // print('eaaaaaaaaaaaaaaaa');
                  return selesai(context, name ?? "", price ?? "", img ?? "");
                }
                ;
              }),
        ),
      );
    } catch (e) {
      return Scaffold(
        body: Text(e.toString()),
      );
    }
  }
}

//##################CLASS#################################
selesai(BuildContext context, String title, int price, String url) {
  final formatter = NumberFormat('#,###', 'en_US');

  try {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      margin: EdgeInsets.only(left: 15.0, bottom: 7.5, right: 15.0, top: 7.5),
      child: InkWell(
        onTap: () {
          print("item di tekan");
        },
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Border radius jika ingin border rounded
            side: BorderSide(
              color: Color(0xFFE5E5E5), // Warna border
              width: 2.0, // Ketebalan border
            ),
          ),
          // margin: EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            // color: Colors.purple,
            // padding: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  width: 120,
                  height: 120,
                  // color: Colors.grey,
                  margin: EdgeInsets.all(10),
                  // padding: EdgeInsets.all(0),
                  child: Image.network(
                    '$url', // atau Image.network untuk gambar dari URL
                    fit: BoxFit
                        .cover, // Mengubah ini sesuai kebutuhan: cover, contain, fill, fitWidth, fitHeight
                  ),
                ),
                Container(
                  width: 177,
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        '$title',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text('RP. ${formatter.format(price)}'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Penilaianmu'),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 14,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 14,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 14,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 14,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.star_half,
                              color: Colors.black,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // foregroundColor: Color(0xFFCACACA),
                                backgroundColor: Color(0xFF19FF3E),
                                elevation: 30,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                minimumSize: Size(20, 30),
                                shadowColor: Colors.black,
                              ),
                              onPressed: () {
                                print('selesai');
                              },
                              child: Text(
                                'Selesai',
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  } catch (e) {
    return Text(e.toString());
  }
}

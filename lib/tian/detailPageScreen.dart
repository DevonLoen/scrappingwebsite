import "dart:html";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:scrappingwebsite/tian/colorPickerDetailPageWidget.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import "package:shared_preferences/shared_preferences.dart";
import 'dart:math';

class DetailPageWidget extends StatefulWidget {
  final String rating;
  final String name;
  final String img;
  final String price;
  final bool isToped;
  final String linkdetail;

  DetailPageWidget(
      {required this.rating,
      required this.name,
      required this.img,
      required this.price,
      required this.isToped,
      required this.linkdetail});

  @override
  State<DetailPageWidget> createState() => _DetailPageWidgetState();
}

class _DetailPageWidgetState extends State<DetailPageWidget> {
  final List DeskripsiList = ["ngetes", 'ngetes', 'aja'];
  List<String> color = [];
  List<String> size = [];
  String description = '';
  List<Color> colortype = [];
  int rating = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    rating = BulatkanRating();
  }

  int BulatkanRating() {
    String nilaiString = widget.rating;

    // Konversi string ke double
    double nilaiDouble = double.parse(nilaiString);

    // Bulatkan nilai ke atas
    int nilaiBulat = nilaiDouble.ceil();

    print("Nilai string: $nilaiString");
    print("Nilai bulat ke atas: $nilaiBulat");
    return nilaiBulat;
  }

  Map<String, Color> colorTranslationMap = {
    'merah': Colors.red,
    'biru': Colors.blue,
    'hijau': Colors.green,
    'kuning': Colors.yellow,
    'hitam': Colors.black,
    'putih': Colors.white,
    'cokelat': Colors.brown,
    'jingga': Colors.orange,
    'abu-abu': Colors.grey,
    'ungu': Colors.purple,
    'merah muda': Colors.pink,
    'emas': Colors
        .amber, // Colors.gold is not available in Flutter, using Colors.amber
    'perak': Colors
        .blueGrey, // Colors.silver is not available in Flutter, using Colors.blueGrey
  };

  Set<String> validColorsInEnglish = {
    'red',
    'blue',
    'green',
    'yellow',
    'black',
    'white',
    'brown',
    'orange',
    'grey',
    'gray',
    'purple',
    'pink',
    'amber',
    'blueGrey'
  };

  List<Color> translateColorsToEnglish(List<String> colorsInIndonesian) {
    // List untuk menyimpan warna yang sudah diterjemahkan
    List<Color> colorsInEnglish = [];

    // Iterasi melalui setiap warna dalam daftar
    for (String color in colorsInIndonesian) {
      String colorLower = color.toLowerCase();
      if (colorTranslationMap.containsKey(colorLower)) {
        // Jika warna ada di peta terjemahan, tambahkan warna ke daftar
        colorsInEnglish.add(colorTranslationMap[colorLower]!);
      } else if (validColorsInEnglish.contains(colorLower)) {
        // Jika warna sudah dalam bahasa Inggris, tambahkan langsung
        colorsInEnglish.add(_getColorFromName(colorLower));
      }
      // Jika warna tidak ada di peta dan bukan warna valid dalam bahasa Inggris, abaikan
    }

    return colorsInEnglish;
  }

  Color _getColorFromName(String colorName) {
    switch (colorName) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'brown':
        return Colors.brown;
      case 'orange':
        return Colors.orange;
      case 'gray':
      case 'grey':
        return Colors.grey;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'amber':
        return Colors.amber;
      case 'blueGrey':
        return Colors.blueGrey;
      default:
        return Colors.transparent; // or throw an exception
    }
  }

  Future<void> fetchData() async {
    try {
      Map<String, dynamic> data =
          await fetchAndConvertData(); // Tunggu hingga data selesai diambil

      setState(() {
        // Update state dengan data yang sudah diambil
        color = data['color'];
        size = data['size'];
        description = data['description'];
        colortype = translateColorsToEnglish(data['color']);
      });

      // Print data (optional)
      print('Fetched data:');
      print('Color: $color');
      print('Size: $size');
      print('Description: $description');
    } catch (e) {
      // Handle errors
      print('Error fetching data: $e');
      // Tambahkan logika penanganan kesalahan jika diperlukan
    }
  }

  Future<Map<String, dynamic>> fetchAndConvertData() async {
    try {
      dynamic datadetail =
          await getdatadetail(); // Tunggu sampai data selesai diambil

      // Access and convert data
      List<String> color = List<String>.from(datadetail['data']['color'] ?? []);
      List<String> size = List<String>.from(datadetail['data']['size'] ?? []);
      String description = datadetail['data']['description'] ?? '';

      // Return the data as a map
      return {
        'color': color,
        'size': size,
        'description': description,
      };
    } catch (e) {
      // Handle errors
      print('Error fetching data: $e');
      // Return empty values or throw an exception based on your error handling strategy
      return {
        'color': [],
        'size': [],
        'description': '',
      };
    }
  }

  String urlSplit(String url) {
    List<String> arr = url.split("/");

    String urlsplited = widget.isToped
        ? "http://localhost:3000/api/v1/scrapping/detail?marketplace=tokopedia&title=${arr[3]}&text=${arr[4]}"
        : "http://localhost:3000/api/v1/scrapping/detail?marketplace=bukalapak&title=${arr[3]}&type=${arr[4]}&text=${arr[5]}";
    return urlsplited;
  }

  Future<dynamic> getdatadetail() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('ini adalah token');
    print(token);
    String urlparse = urlSplit(widget.linkdetail);
    try {
      final response = await http.get(
        Uri.parse(urlparse),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "${token}"
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw (jsonDecode(response.body)['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

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
              SizedBox(
                height: 60,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width - 75),
                child: Column(children: [
                  Image.network(
                    widget.img,
                    fit: BoxFit.fitWidth,
                  ),
                  // color: Colors.amber,

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 24),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      // ListView.builder(
                      //   itemCount: 4,
                      //   itemBuilder: (context, index) {
                      //     return Icon(
                      //         IconData(0xe5f9, fontFamily: 'MaterialIcons'));
                      //   },
                      // ),
                      Container(
                        // color: Colors.red,
                        width: 120,
                        height: 30,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: rating,
                          itemBuilder: (context, index) {
                            return Icon(
                                IconData(0xe5f9, fontFamily: 'MaterialIcons'));
                          },
                        ),
                      ),

                      // Icon(IconData(0xe5f9, fontFamily: 'MaterialIcons')),
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
                  list: colortype,
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
                  list: size,
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
                                // '• ${DeskripsiList[index]}',
                                description,
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

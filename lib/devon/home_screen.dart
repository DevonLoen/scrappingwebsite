import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scrappingwebsite/devon/history_screen.dart';
import 'package:scrappingwebsite/devon/profile_screen.dart';
import 'package:scrappingwebsite/devon/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  int _selectedindex = 2;
  final TextEditingController _searchcontroller = TextEditingController();

  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    // Now you can use prefs throughout your widget!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                  spreadRadius: 15, // Jangkauan bayangan
                  // blurRadius: 10, // Jarak blur bayangan
                  // offset: Offset(4, 4), // Offset bayangan (x, y)
                ),
              ],
            ),
            width: double.infinity,
            height: 130.0,
            child: Text(''),
          ),
          SizedBox(
            height: 35.0,
          ),
          Center(
            child: Text(
              'Find Out Your Item Here',
              style: TextStyle(
                fontSize: 25, // Ukuran font
                // fontStyle: FontStyle.italic, // Gaya font (miring)
                fontWeight: FontWeight.bold, // Berat font (tebal)
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Container(
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.blue, width: 2)),
              width: 300.0,
              height: 45.0,
              child: TextField(
                controller: _searchcontroller,
                decoration: InputDecoration(
                  hintText: 'Search Here...',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Menambahkan radius
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 3, // Warna border saat TextField tidak dipilih
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 3, // Warna border saat TextField dipilih
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 37.0,
              ),
              Text(
                'Recommendation',
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                side: BorderSide(color: Colors.orange),
                label: Text(
                  "Shirt",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.orange,
                      fontWeight: FontWeight.normal),
                ),
                selected:
                    "no" == _searchcontroller.text, //checklist pada choice chip
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24.0), // Menambahkan radius
                ),
                onSelected: (value) {
                  setState(() {
                    _searchcontroller.text = "Shirt";
                    // controller.closeView("Testing");
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              ChoiceChip(
                side: BorderSide(color: Colors.orange),
                label: Text(
                  "Gaming Laptop",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.orange,
                      fontWeight: FontWeight.normal),
                ),
                selected:
                    "no" == _searchcontroller.text, //checklist pada choice chip
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24.0), // Menambahkan radius
                ),
                onSelected: (value) {
                  setState(() {
                    _searchcontroller.text = "Gaming Laptop";
                    // controller.closeView("Testing");
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              ChoiceChip(
                side: BorderSide(color: Colors.orange),
                label: Text(
                  "PC",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.orange,
                      fontWeight: FontWeight.normal),
                ),
                selected:
                    "no" == _searchcontroller.text, //checklist pada choice chip
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24.0), // Menambahkan radius
                ),
                onSelected: (value) {
                  setState(() {
                    _searchcontroller.text = "PC";
                    // controller.closeView("Testing");
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                side: BorderSide(color: Colors.orange),
                label: Text(
                  "Keyboard Gaming",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.orange,
                      fontWeight: FontWeight.normal),
                ),
                selected:
                    "no" == _searchcontroller.text, //checklist pada choice chip
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24.0), // Menambahkan radius
                ),
                onSelected: (value) {
                  setState(() {
                    _searchcontroller.text = "Keyboard Gaming";
                    // controller.closeView("Testing");
                  });
                },
              ),
              SizedBox(
                width: 35,
              ),
              ChoiceChip(
                side: BorderSide(color: Colors.orange),
                label: Text(
                  "Mouse",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.orange,
                      fontWeight: FontWeight.normal),
                ),
                selected:
                    "no" == _searchcontroller.text, //checklist pada choice chip
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24.0), // Menambahkan radius
                ),
                onSelected: (value) {
                  setState(() {
                    _searchcontroller.text = "Mouse";
                    // controller.closeView("Testing");
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                side: BorderSide(color: Colors.orange),
                label: Text(
                  "ID",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.orange,
                      fontWeight: FontWeight.normal),
                ),
                selected:
                    "no" == _searchcontroller.text, //checklist pada choice chip
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24.0), // Menambahkan radius
                ),
                onSelected: (value) {
                  setState(() {
                    _searchcontroller.text = "ID";
                    // controller.closeView("Testing");
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              ChoiceChip(
                side: BorderSide(color: Colors.orange),
                label: Text(
                  "Jeans",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.orange,
                      fontWeight: FontWeight.normal),
                ),
                selected:
                    "no" == _searchcontroller.text, //checklist pada choice chip
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24.0), // Menambahkan radius
                ),
                onSelected: (value) {
                  setState(() {
                    _searchcontroller.text = "Jeans";
                    // controller.closeView("Testing");
                  });
                },
              ),
              SizedBox(
                width: 18,
              ),
              ChoiceChip(
                side: BorderSide(color: Colors.orange),
                label: Text(
                  "Voucher BBM",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.orange,
                      fontWeight: FontWeight.normal),
                ),
                selected:
                    "no" == _searchcontroller.text, //checklist pada choice chip
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(24.0), // Menambahkan radius
                ),
                onSelected: (value) {
                  setState(() {
                    _searchcontroller.text = "Voucher BBM";
                    // controller.closeView("Testing");
                  });
                },
              ),
            ],
          ),
          //#####################SEARCH ANCHOR #################################,
          SizedBox(
            height: 50,
          ),

          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFFCACACA),
                backgroundColor: Colors.orange,
                elevation: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.10)),
                minimumSize: Size(200, 45),
                shadowColor: Colors.black,
              ),
              onPressed: () async {
                try {
                  print("ini searchingg");
                  final response = await searchData(_searchcontroller.text);
                  print('response searchh');
                  print(response.runtimeType);
                  Navigator.pushNamed(context, '/itemsResult',
                      arguments: response);
                } catch (e) {
                  prefs.clear();
                  print('prefs.getString("token") in searchdata error');
                  print(prefs.getString("token"));
                  print(e);
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  setState(() => {});
                }
              },
              child: Text('Find Out'),
            ),
          ),
        ],
      ),
    );
  }
}

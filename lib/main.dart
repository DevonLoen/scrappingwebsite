import 'package:flutter/material.dart';
import 'package:scrappingwebsite/devon/history_screen.dart';
import 'package:scrappingwebsite/devon/home_screen.dart';
import 'package:scrappingwebsite/item_screen.dart';
import 'package:scrappingwebsite/devon/login_screen.dart';
import 'package:scrappingwebsite/pembayaran_popup.dart';
import 'package:scrappingwebsite/devon/profile_screen.dart';
import 'package:scrappingwebsite/testing.dart';
import 'package:scrappingwebsite/devon/welcome_screen.dart';
import 'package:scrappingwebsite/devon/login_screen.dart';
import 'package:scrappingwebsite/devon/profile_screen.dart';
import 'package:scrappingwebsite/devon/welcome_screen.dart';
import 'package:provider/provider.dart';
// import 'package:scrappingwebsite/devon/user_provider.dart';
import 'package:scrappingwebsite/tian/CartPage.dart';
import 'package:scrappingwebsite/tian/PurchasePage.dart';
import 'package:scrappingwebsite/tian/cartListProvider.dart';
import 'package:scrappingwebsite/tian/detailPageScreen.dart';
import 'package:scrappingwebsite/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserListProvider()),
        ChangeNotifierProvider(create: (context) => CartListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scraping data website',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        // home: Pembayaran_popup(
        //     name: 'DEVddddddddddddddddddddddddddON',
        //     number: '01341343',
        //     rekening: '12324423',
        //     item: 'Nike black panda',
        //     total: '3.125.000'),
        home: PurchasePage(),
      ),
    );
  }
}

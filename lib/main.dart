import 'package:flutter/material.dart';
import 'package:scrappingwebsite/devon/login_screen.dart';
import 'package:scrappingwebsite/devon/profile_screen.dart';
import 'package:scrappingwebsite/devon/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:scrappingwebsite/devon/user_provider.dart';
import 'package:scrappingwebsite/tian/CartPage.dart';
import 'package:scrappingwebsite/tian/PurchasePage.dart';
import 'package:scrappingwebsite/tian/cartListProvider.dart';
import 'package:scrappingwebsite/tian/detailPageScreen.dart';

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
        home: const PurchasePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';
import 'package:scrappingwebsite/dashboard_screen.dart';
import 'package:scrappingwebsite/devon/history_screen.dart';
import 'package:scrappingwebsite/devon/home_screen.dart';
import 'package:scrappingwebsite/devon/login_screen.dart';
import 'package:scrappingwebsite/devon/profile_screen.dart';
import 'package:scrappingwebsite/devon/user_provider.dart';
import 'package:scrappingwebsite/item_screen.dart';
import 'package:scrappingwebsite/testing.dart';
import 'package:scrappingwebsite/devon/welcome_screen.dart';
import 'package:scrappingwebsite/tian/PurchasePage.dart';
import 'package:scrappingwebsite/tian/cartListProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
=======
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
>>>>>>> baf69cfc124526785f899bfafbbbdc2373fc87f7

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.containsKey("token");
  print('prefs.getString("token")');
  print(prefs.getString("token"));
  print('isLoggedIn ATAS');
  print(isLoggedIn);
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserListProvider()),
        ChangeNotifierProvider(create: (context) => CartListProvider()),
        ChangeNotifierProvider(create: (context) => Auth())
      ],
      child: MaterialApp(
<<<<<<< HEAD
          initialRoute: this.isLoggedIn ? "/HomeScreen" : "/",
          routes: {
            '/': (context) => Login_screen(),
            '/HomeScreen': (context) => Dashboard_screen(),
            "/PurchasePage": (context) => PurchasePage(),
            "/itemsResult": (context) => Item_Screen()
          },
          debugShowCheckedModeBanner: false,
          title: 'Scraping data website',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          )),
      // home: this.isLoggedIn ? Home_screen() : Login_screen()),
      // home: Testing()),
=======
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
>>>>>>> baf69cfc124526785f899bfafbbbdc2373fc87f7
    );
  }
}

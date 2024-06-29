import 'package:flutter/material.dart';
import 'package:scrappingwebsite/devon/home_screen.dart';
import 'package:scrappingwebsite/devon/login_screen.dart';
import 'package:scrappingwebsite/devon/profile_screen.dart';
import 'package:scrappingwebsite/devon/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:scrappingwebsite/devon/user_provider.dart';
import 'package:scrappingwebsite/tian/CartPage.dart';
import 'package:scrappingwebsite/tian/PurchasePage.dart';
import 'package:scrappingwebsite/tian/cartListProvider.dart';
import 'package:scrappingwebsite/tian/detailPageScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.containsKey("token");
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
          debugShowCheckedModeBanner: false,
          title: 'Scraping data website',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: this.isLoggedIn ? Home_screen() : Login_screen()),
    );
  }
}

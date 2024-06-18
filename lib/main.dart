import 'package:flutter/material.dart';
import 'package:scrappingwebsite/history_screen.dart';
import 'package:scrappingwebsite/home_screen.dart';
import 'package:scrappingwebsite/login_screen.dart';
import 'package:scrappingwebsite/profile_screen.dart';
import 'package:scrappingwebsite/testing.dart';
import 'package:scrappingwebsite/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:scrappingwebsite/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserListProvider(), // Buat instance ItemListProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scraping data website',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: Welcome_screen(),
      ),
    );
  }
}

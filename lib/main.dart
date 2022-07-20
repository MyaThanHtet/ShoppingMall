import 'package:flutter/material.dart';
import 'package:shopping_mall/ui/MySplashPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MySplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

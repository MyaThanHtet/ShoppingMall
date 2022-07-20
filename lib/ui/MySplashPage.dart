import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_mall/ui/LoginScreen.dart';
import 'package:shopping_mall/ui/MyHomeScreen.dart';

class MySplashPage extends StatefulWidget {
  const MySplashPage({Key? key}) : super(key: key);

  @override
  _MySplashPageState createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  late bool isLogin = false;

  @override
  void initState() {
    super.initState();
    _isLogin();

    Timer(const Duration(seconds: 3), () {
      if (isLogin) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomeScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  void _isLogin() async {
    var preferences = await SharedPreferences.getInstance();
    isLogin = preferences.getBool("ISLOGIN")!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: const FlutterLogo(size: 50));
  }
}

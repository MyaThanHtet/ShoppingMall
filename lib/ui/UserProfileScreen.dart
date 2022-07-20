import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_mall/ui/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shopping_mall/user_view_model.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String loginedUser = "";
  void _Logout() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.remove("ISLOGIN");
    await preferences.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
    getLogedInData();
  }

  getLogedInData() async {
    var preferences = await SharedPreferences.getInstance();
    loginedUser = preferences.getString("userName")!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          getLogedInData();
        });
      },
      child: Container(
        color: const Color(0xffC4DFCB),
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            const SizedBox(
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://static.remove.bg/remove-bg-web/5c20d2ecc9ddb1b6c85540a333ec65e2c616dbbd/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png")),
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              loginedUser,
              style: TextStyle(
                color: Colors.green[900],
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      setState(() {
                        _Logout();
                      });
                    },
                  )),
            )
          ],
        )),
      ),
    );
  }
}

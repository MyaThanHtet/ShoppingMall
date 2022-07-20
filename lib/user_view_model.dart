import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  String _username = "";

  String get username => _username;

  void getLogedInData() async {
    var preferences = await SharedPreferences.getInstance();
    _username = preferences.getString("userName")!;
    notifyListeners();
  }
}

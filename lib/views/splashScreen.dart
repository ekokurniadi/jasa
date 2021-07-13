import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jasa_app/views/auth/auth.dart';
import 'package:jasa_app/views/home/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userID = "";
  String userRole = "";
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    start();
  }

  start() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      if (userID == null) {
        Get.to(Auth());
      } else if (userID != null && userRole == "user") {
        Get.off(Index());
      } else if (userID != null && userRole == "vendor") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Auth()));
      }
    });
  }

  getCurrentUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.get("id");
    var role = sharedPreferences.get("role");
    setState(() {
      userID = user;
      userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

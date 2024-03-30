import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_todolist/pages/home_page.dart';
import 'package:my_todolist/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalName;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => finalName == null
                      ? const LoginPage()
                      : HomePage(user: finalName,))));
    });
    super.initState();
  }

  Future getValidationData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var nameResult = sharedPreferences.getString('name');

    setState(() {
      finalName = nameResult;
    });
    print("$finalName");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

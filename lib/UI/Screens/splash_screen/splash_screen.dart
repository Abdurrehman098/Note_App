import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Core/constant/strings.dart';
import 'package:note_app/UI/Utils/route_helper.dart';
import 'package:note_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (auth.currentUser == null) {
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          RouteHelper.login,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          RouteHelper.home,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "$staticAssets/splash.png",
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}

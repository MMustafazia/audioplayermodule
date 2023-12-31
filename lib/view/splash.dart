import 'package:audioplayer/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenWS extends StatefulWidget {
  const SplashScreenWS({super.key});

  @override
  State<SplashScreenWS> createState() => _SplashScreenWSState();
}

class _SplashScreenWSState extends State<SplashScreenWS> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (_) => HomeViewScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(child: Image.asset("assets/images/logo.png")),
    );
  }
}

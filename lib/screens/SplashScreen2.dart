import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chcenterthennala/screens/Homepage.dart';

import 'NewHomeScreen.dart';

class Splashscreen2 extends StatefulWidget {
  const Splashscreen2({super.key});

  @override
  State<Splashscreen2> createState() => _ScreensplashState();
}

class _ScreensplashState extends State<Splashscreen2> {
  gotoHomepage() {
    Timer(const Duration(seconds: 2), () => Get.off(MyHomePage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotoHomepage();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 151,
            height: 155,
            decoration: BoxDecoration(),
            child: Image.asset("assets/thennala/chthennala_logo.jpg"),
          ),
        ),
      ),
    );
  }
}

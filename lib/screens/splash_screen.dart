import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tazzakhabar/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeScreen())) as void Function());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: const Center(
          child: Text(
        'TazzaKhabar',
        style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.bold),
      )),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_manager/Widgets/Widgets.dart';
import 'package:money_manager/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "Logo",
          child: Image.asset("Assets/Images/money.jpg"),
        ),
      ),
    );
  }

  startTimer(){
   Timer(Duration(seconds: 2), navShift(context, MyHomePage(),IF: true));
  }

  @override
  void initState() {
startTimer();
  }
}

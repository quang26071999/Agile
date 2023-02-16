import 'dart:async';

import 'package:flutter/material.dart';
import 'package:polycoffe_agile/Screen/DangNhapScreen.dart';
import 'package:get/get.dart';

class HelloScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    home: Home(),
  );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), (){
      Get.off(DangNhapScreen());
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/helloScreen.png'),
            fit: BoxFit.fill,
          )
        ),
      ),
    );

  }
}
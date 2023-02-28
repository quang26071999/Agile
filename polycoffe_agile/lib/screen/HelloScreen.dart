import 'dart:async';

import 'package:flutter/material.dart';
import 'package:polycoffe_agile/Screen/DangNhapScreen.dart';
import 'package:get/get.dart';
import 'package:polycoffe_agile/Screen/DatBanScreen.dart';
import 'package:polycoffe_agile/Screen/MenuScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelloScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    home: Home(),
  );
  }
}

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  SharedPreferences? login;
  String? role,username;
  @override
  void initState() {

    super.initState();
  }
  Future<void> init() async {
    login = await SharedPreferences.getInstance();
    setState(() {
      role = login!.getString('role');
      username = login!.getString('username');
    });
  }
  @override
  Widget build(BuildContext context) {
    if(login == null){
      Timer(const Duration(seconds: 3), (){
            Get.off(DangNhapScreen());
          });
    }else{
      Timer(const Duration(seconds: 3), (){
        Get.off(MenuScreen());
      });
    }

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
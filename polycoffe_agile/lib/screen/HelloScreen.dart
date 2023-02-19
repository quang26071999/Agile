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

// class Home extends StatelessWidget {
//   Future<SharedPreferences> login = SharedPreferences.getInstance();
//
//   @override
//   Widget build(BuildContext context) {
//     Timer(Duration(seconds: 3), (){
//       Get.off(DangNhapScreen());
//     });
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/helloScreen.png'),
//             fit: BoxFit.fill,
//           )
//         ),
//       ),
//     );
//
//   }
// }
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
    if(username ==null ){
      Timer(const Duration(seconds: 3), (){
        Get.off(DangNhapScreen());
      });
    }else if(username != null && role == 'Admin' ){
      Timer(const Duration(seconds: 3), (){
        Get.off(const MenuScreen());
      });
    }else if(username != null && role == 'Nhân viên'){
      Timer(const Duration(seconds: 3), (){
        Get.off(const DatBanScreen());
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
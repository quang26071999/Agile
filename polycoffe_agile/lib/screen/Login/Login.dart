import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:polycoffe_agile/main.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.brown,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 140,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 170, 0, 0),
                child: Text(
                  "POLY COFFEE",
                  style: TextStyle(fontSize: 40,color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                child: TextField(
                  controller: usernameController,
                  style: const TextStyle(fontSize: 18,color: Colors.brown),
                  decoration: InputDecoration(
                    labelText: "Usename",
                    prefixIcon: Container(
                      width: 50, child: Icon(Icons.person)),
                    border: const OutlineInputBorder(
                      borderSide:
                        BorderSide(color: Colors.blueAccent,width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              TextField(
                controller: passwordController,
                style: const TextStyle(fontSize: 18,color: Colors.brown),
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Container(
                        width: 50, child: Icon(Icons.key)),
                    border: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.blueAccent,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if(usernameController.text == "admin" && passwordController.text == "admin"){

                        Get.off(MyApp());
                        Get.snackbar("Successfully", "Dang nhap thanh cong");
                    } else{
                        Get.snackbar("Error", "sai thong tin dang nhap");
                    }
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(color: Colors.white,fontSize: 18),
                  ),

                ),
              ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
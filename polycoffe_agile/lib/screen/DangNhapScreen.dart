import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:polycoffe_agile/main.dart';

class DangNhapScreen extends StatelessWidget {
   DangNhapScreen({super.key});
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
   bool? check1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background5.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),

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
                  style: TextStyle(fontSize: 40,color: Colors.black,fontWeight: FontWeight.w900,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                child: TextField(
                  controller: usernameController,
                  style: const TextStyle(fontSize: 18,color: Colors.black,),
                  decoration: InputDecoration(
                      labelText: "Usename",
                      filled: true,
                      fillColor:   Color(0xffDECDB9),
                      prefixIcon: Container(
                          width: 50, child: Icon(Icons.person)),
                      border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black,width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextField(
                    controller: passwordController,
                    style: const TextStyle(fontSize: 18,color: Colors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        filled: true,
                        fillColor:   Color(0xffDECDB9),
                        prefixIcon: Container(
                            width: 50, child: Icon(Icons.key)),
                        border: const OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(25)))),
                  ),
                  // Image(image: Image.asset(eye.png))
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 300, 0),
              //   child: new  Checkbox( //checkbox positioned at left
              //     value: check1,
              //     onChanged: (bool? value) {
              //       setState(() {
              //         check1 = value;
              //       });
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: TextButton(
                    onPressed: () {
                      if(usernameController.text == "admin" && passwordController.text == "admin"){

                        Get.off(MyApp());
                        Get.snackbar("Successfully", "Dang nhap thanh cong");
                      } else{
                        Get.snackbar("Error", "sai thong tin dang nhap");
                      }
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.brown[900]
                    ),
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(color: Colors.white,fontSize: 24,),
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

  void setState(Null Function() param0) {}
}
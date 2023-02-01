import 'package:flutter/material.dart';
import 'package:polycoffe_agile/Login/Register.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
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
                  style: TextStyle(fontSize: 18,color: Colors.brown),
                  decoration: InputDecoration(
                    labelText: "Usename",
                    prefixIcon: Container(
                      width: 50, child: Image.asset("account_circle.png")),
                    border: OutlineInputBorder(
                      borderSide:
                        BorderSide(color: Colors.blueAccent,width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              TextField(
                style: TextStyle(fontSize: 18,color: Colors.brown),
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Container(
                        width: 50, child: Image.asset("key.png")),
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.blueAccent,width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
              Container(
                constraints: BoxConstraints.loose(Size(double.infinity,30)),
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                      "forgot password?",
                  style: TextStyle(fontSize: 16,color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
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
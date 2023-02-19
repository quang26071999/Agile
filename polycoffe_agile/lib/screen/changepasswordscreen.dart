import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TaiKhoanScreen.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangePass(),
    );
  }
}

class ChangePass extends StatefulWidget {
  @override
  _ChangePass createState() => _ChangePass();
}

class _ChangePass extends State<ChangePass> {
  final TextEditingController _oldPass = TextEditingController();
  final TextEditingController _newPass = TextEditingController();
  final TextEditingController _reNewPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late SharedPreferences logindata;
  String? user;
  String? password;

  @override
  void initState() {
    super.initState();
    initial();
  }

  Future<void> initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      user = logindata.getString("username")!;
      password = logindata.getString("password")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color(0xffAE8E6F)),
        child: SafeArea(
          child: Container(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Thay đổi mật khẩu",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: Color(0xffffffff),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
              Padding(padding: EdgeInsets.only(left: 36, right: 36),child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 56, bottom: 24),child: TextFormField(
                        controller: _oldPass,
                        style: GoogleFonts.inter(
                            fontSize: 16, fontStyle: FontStyle.italic),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffDECDB9),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            hintText: "Nhập mật khẩu cũ",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(),
                            )),
                        validator: (text) {
                          if (text == null ||
                              text.isEmpty) {
                            return 'Vui lòng nhập mật khẩu cũ';
                          }
                          if(text != password.toString()){
                            return 'Mật khẩu cũ chưa chính xác';
                          }
                          return null;
                        },
                      ),),
                      Padding(padding: EdgeInsets.only(bottom: 24),child: TextFormField(
                        controller: _newPass,
                        style: GoogleFonts.inter(
                            fontSize: 16, fontStyle: FontStyle.italic),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffDECDB9),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            hintText: "Nhập mật khẩu mới",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(),
                            )),
                        validator: (text) {
                          if (text == null ||
                              text.isEmpty) {
                            return 'Vui lòng nhập mật khảu mới';
                          }
                          return null;
                        },
                      ),),
                      Padding(padding: EdgeInsets.only(bottom: 40),child: TextFormField(
                        controller: _reNewPass,
                        style: GoogleFonts.inter(
                            fontSize: 16, fontStyle: FontStyle.italic),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffDECDB9),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            hintText: "Nhập lại mật khẩu mới",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(),
                            )),
                        validator: (text) {
                          if (text == null ||
                              text.isEmpty) {
                            return "Vui lòng nhập lại mật khảu mới";
                          }
                          if(text != _newPass.text){
                            return "Mật khẩu mới nhập lại không khớp";
                          }
                          return null;
                        },
                      ),),

                      Container(
                        width: 288,
                        child: TextButton(
                          onPressed: () {
                            // _formKey.currentState!.validate();
                            print('USER ${user}');
                            if(_formKey.currentState!.validate()){
                              var documentReference = FirebaseFirestore.instance.collection("User").doc(user);
                              documentReference.update({
                                "password": _newPass.text
                              })
                                  .then((value) =>
                                  // debugPrint("Sửa thành công")
                                Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => TaiKhoanScreen()))
                              )
                                  .catchError((error) => debugPrint("Sửa thất bại:  ${error}"));


                            }else{
                              print("false");
                            }
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.brown[900],
                          ),
                          child: Text(
                            "Thay đổi",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                        ),)
                    ],
                  ),)),)
            ],
          ),)
        ));
  }
}
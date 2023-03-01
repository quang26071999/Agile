import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class DangNhapScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyLogin(),
    );
  }

}
class MyLogin extends StatefulWidget{
  @override
  _MyLoginState createState() => _MyLoginState();

}
class _MyLoginState extends State<MyLogin>{

    final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  late SharedPreferences logindata;
  late bool newuser;
  late bool _passVisible;
    final _formKey = GlobalKey<FormState>();

    bool _rememberMe = false;

  @override
  void initState() {
    check_login();
    _passVisible = false;
    super.initState();
  }



    Future<void> check_login() async {
    logindata = await SharedPreferences.getInstance() ;
    newuser = logindata.getBool("login")!;
    
    if(newuser){
     // Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MyStatefulWidget()));
      Get.off(MyStatefulWidget(selectIndex: 0,));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffAE8E6F),
        ),
        // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  // height: 140,
                ),
                Container(
                  width: 300,
                  height: 250,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cafe.png'),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(61, 0, 50, 0),
                  child: Text(
                    "POLY COFFEE",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 36,
                              color: Colors.black,
                              fontWeight:
                              FontWeight.w900))
                    // fontFamily: Inter,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 30, 36, 35),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: usernameController,
                    style:  GoogleFonts.inter(fontSize: 20,color: Colors.black,),
                    decoration: InputDecoration(
                        labelText: "Username",
                        filled: true,
                        fillColor:   Color(0xffDECDB9),
                        prefixIcon: Container(
                            width: 50, child: Icon(Icons.person)),
                        border: const OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black,width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        )
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Vui lòng không để trống";
                      }
                      if(!RegExp(r'^(84|0)+([0-9]{9})+$').hasMatch(value!)){
                        return "Số điện thoại không đúng định dạng";
                      }
                      else{
                        return null;
                      }
                    },

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 0, 36, 8),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextFormField(
                        controller: passwordController,
                        style:  GoogleFonts.inter(fontSize: 20,color: Colors.black),
                        obscureText: !_passVisible,
                        decoration: InputDecoration(
                            labelText: "Password",
                            filled: true,
                            fillColor:   Color(0xffDECDB9),
                            prefixIcon: Container(
                                width: 50, child: Icon(Icons.key)),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _passVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: (){
                                  setState(() {
                                    _passVisible = !_passVisible;
                                  });
                                }),
                            border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black,width: 2),
                                borderRadius: BorderRadius.all(Radius.circular(20)))),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Vui lòng không để trống";
                          }
                          return null;
                        },
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 36, 50),
                  child: CheckboxListTile(
                    title: const Text('Nhớ tài khoản',
                      style: TextStyle(fontSize: 20,color: Colors.black),),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _rememberMe,
                    onChanged:(bool? value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                ),

                // suffixIcon
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          final userRef = FirebaseFirestore.instance.collection("User").doc(usernameController.text);
                          userRef.get().then((doc)  async {
                            if(!doc.exists){
                              Get.snackbar("Error", "Sai thong tin dang nhap");

                            } else{
                              if(usernameController.text == doc["username"] && passwordController.text == doc["password"]){
                                  await logindata.setBool("login", _rememberMe);
                                  await logindata.setString("username", usernameController.text);
                                  await logindata.setString("name", doc['hoTen']);
                                  await logindata.setString("dateOfBirth", doc['ngaySinh']);
                                  await logindata.setString("sex", doc['gioiTinh']);
                                  await logindata.setString("avatar", doc['avatar']);
                                  await logindata.setString("role", doc['role']);
                                  await logindata.setString("address", doc['diaChi']);
                                  await logindata.setString("password", doc['password']);

                                //final User user = User(doc['username'], doc['password'], doc['hoTen'], doc['role'], doc['gioiTinh'], doc['diaChi'], doc['avatar'], doc['ngaySinh']);
                                Get.snackbar("Successfully", "Dang nhap thanh cong");
                                Get.off(() => MyApp(selectIndex: 0,));
                              }
                              else{
                                Get.snackbar("Error", "Sai thong tin dang nhap");
                              }
                            }


                          }
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.brown[900],
                      ),
                      child: Text(
                        "Đăng nhập",
                        style: GoogleFonts.inter(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }

}

// class DangNhapScreen extends StatelessWidget {
//     DangNhapScreen({super.key});
//   final TextEditingController usernameController = new TextEditingController();
//   final TextEditingController passwordController = new TextEditingController();
//
//   //  SharedPreferences logindata;
//   // final bool newuser;
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/background5.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//         constraints: BoxConstraints.expand(),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 // height: 140,
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(61, 261, 50, 0),
//                 child: Text(
//                   "POLY COFFEE",
//                     style: GoogleFonts.inter(
//                         textStyle: const TextStyle(
//                             fontSize: 36,
//                             color: Colors.black,
//                             fontWeight:
//                             FontWeight.w900))
//                   // fontFamily: Inter,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(36, 30, 36, 35),
//                 child: TextField(
//                   controller: usernameController,
//                   style:  GoogleFonts.inter(fontSize: 20,color: Colors.black,),
//                   decoration: InputDecoration(
//                       labelText: "Usename",
//                       filled: true,
//                       fillColor:   Color(0xffDECDB9),
//                       prefixIcon: Container(
//                           width: 50, child: Icon(Icons.person)),
//                       border: const OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: Colors.black,width: 2),
//                           borderRadius: BorderRadius.all(Radius.circular(20)))),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(36, 0, 36, 8),
//                 child: Stack(
//                   alignment: AlignmentDirectional.centerEnd,
//                   children: <Widget>[
//                     TextField(
//                       controller: passwordController,
//                       style:  GoogleFonts.inter(fontSize: 20,color: Colors.black),
//                       obscureText: true,
//                       decoration: InputDecoration(
//                           labelText: "Password",
//                           filled: true,
//                           fillColor:   Color(0xffDECDB9),
//                           prefixIcon: Container(
//                               width: 50, child: Icon(Icons.key)),
//                           border: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Colors.black,width: 2),
//                               borderRadius: BorderRadius.all(Radius.circular(20)))),
//                     ),
//                     Image.asset("assets/images/eye.png",height: 30,scale: 2,width: 40,)
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 0, 36, 50),
//                 child: CheckboxListTile(
//                   title: const Text('Nhớ mật khẩu',
//                     style: TextStyle(fontSize: 20,color: Colors.black),),
//                   controlAffinity: ListTileControlAffinity.leading,
//                   value: true,
//                   onChanged:(bool? value) { },
//                 ),
//               ),
//
//               // suffixIcon
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(36, 0, 36, 0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: TextButton(
//                     onPressed: () {
//                       final userRef = FirebaseFirestore.instance.collection("User");
//                       userRef.get().then((QuerySnapshot querySnapshot){
//                         querySnapshot.docs.forEach((doc) {
//                           if(usernameController.text == doc["username"] && passwordController.text == doc["password"]){
//                             Get.off(MyApp());
//                           }else if(usernameController.text == "admin" && passwordController.text == "admin"){
//                             Get.off(MyApp());
//                             Get.snackbar("Successfully", "Dang nhap thanh cong");
//                           }
//                           else{
//                             Get.snackbar("Error", "sai thong tin dang nhap");
//                           }
//                         });
//                       }
//                       );
//                     },
//                     style: TextButton.styleFrom(
//                       primary: Colors.white,
//                       backgroundColor: Colors.brown[900],
//                     ),
//                     child: Text(
//                       "Đăng nhập",
//                       style: GoogleFonts.inter(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//
//       ),
//     );
//   }
//
//   void setState(Null Function() param0) {}
// }
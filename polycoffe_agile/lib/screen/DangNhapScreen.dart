import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    check_login();
    _passVisible = false;
    super.initState();
  }



    Future<void> check_login() async {
    logindata = await SharedPreferences.getInstance() ;
    newuser = (logindata.getBool("login") ?? true);
    
    if(newuser == false){
     // Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MyStatefulWidget()));
      Get.off(MyStatefulWidget());
    }

  }

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
        // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                // height: 140,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(61, 261, 50, 0),
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
                child: TextField(
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
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(36, 0, 36, 8),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: passwordController,
                      style:  GoogleFonts.inter(fontSize: 20,color: Colors.black),
                      obscureText: !_passVisible,
                      decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor:   Color(0xffDECDB9),
                          prefixIcon: Container(
                              width: 50, child: Icon(Icons.key)),
                          border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black,width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(20)))),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(270,4,0,0),
                      child:  IconButton(
                          icon: Icon(
                            _passVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: (){
                            setState(() {
                              _passVisible = !_passVisible;
                            });
                          }),

                    )

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 36, 50),
                child: CheckboxListTile(
                  title: const Text('Nhớ mật khẩu',
                    style: TextStyle(fontSize: 20,color: Colors.black),),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: true,
                  onChanged:(bool? value) { },
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
                      final userRef = FirebaseFirestore.instance.collection("User");
                      userRef.get().then((QuerySnapshot querySnapshot){
                        querySnapshot.docs.forEach((doc) async {
                          if(usernameController.text == doc["username"] && passwordController.text == doc["password"]){
                           await logindata.setBool("login", false);
                           await logindata.setString("username", usernameController.text);
                           await logindata.setString("name", doc['hoTen']);
                           await logindata.setString("dateOfBirth", doc['ngaySinh']);
                           await logindata.setString("sex", doc['gioiTinh']);
                           await logindata.setString("avatar", doc['avatar']);
                           await logindata.setString("role", doc['role']);
                           await logindata.setString("address", doc['diaChi']);
                            Get.snackbar("Successfully", "Dang nhap thanh cong");
                            Get.off(MyApp());
                          }else if(usernameController.text == "admin" && passwordController.text == "admin"){
                            logindata.setBool("login", false);
                            logindata.setString("role", 'admin');
                            logindata.setString("username", usernameController.text);

                            Get.off(MyApp());
                            Get.snackbar("Successfully", "Dang nhap thanh cong");
                          }
                          else{
                            Get.snackbar("Error", "sai thong tin dang nhap");
                          }
                        });
                      }
                      );
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
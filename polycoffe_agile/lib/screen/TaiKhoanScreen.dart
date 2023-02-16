
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/constants.dart';
import 'package:polycoffe_agile/screen/DangNhapScreen.dart';
import 'package:polycoffe_agile/screen/EditProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class TaiKhoanScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }

}
class ProfileScreen extends StatefulWidget{
  @override
  ProfileScreenState createState() => ProfileScreenState();

}
class ProfileScreenState extends State<ProfileScreen>{

  @override
  void initState() {
    super.initState();
    initial();
  }

   Future<void> initial() async {
     logindata = await SharedPreferences.getInstance();
     setState(() {
       avatar;
       username;
       name;
       role;
       sex;
       dateOfBirth;
       address;
     });
   }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroundCoffee.png'),
                fit: BoxFit.fill
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20,70,20,0),
          child: SafeArea(

              child: Column(
                children:  <Widget>[
                  Avatar(),
                  Profile(),
                  Padding(
                    padding: EdgeInsets.only(top: 66),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 54,
                          child: TextButton(
                              onPressed: (){},
                              style: TextButton.styleFrom(
                                backgroundColor: Color.fromRGBO(73, 47, 44, 1),
                              ),
                              child: const Text('Đổi mật khẩu',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  )
                              )
                          ),
                        ),
                        Padding(padding:const EdgeInsets.only(top: 30),
                            child: SizedBox(
                              width: double.maxFinite,
                              height: 54,
                              child: TextButton(
                                  onPressed: (){
                                    logindata.setBool("login", true);
                                    //Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MyLogin()));
                                    Get.off(MyLogin());

                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(73, 47, 44, 1),
                                  ),
                                  child: const Text('Đăng xuất',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      )
                                  )
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),

          ),
        ),
      ),
    );
  }

}

// class TaiKhoanScreen extends StatelessWidget {
//   TaiKhoanScreen({super.key});
//  late SharedPreferences logindata;
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/images/backgroundCoffee.png'),
//                   fit: BoxFit.fill
//               ),
//             ),
//             padding: const EdgeInsets.fromLTRB(20,70,20,0),
//             child: Column(
//               children:  <Widget>[
//                 Avatar(),
//                 Profile(),
//                 Buttons(),
//               ],
//             ),
//
//         ),
//       ),
//     );
//   }
// }


class Avatar extends StatelessWidget{
  Avatar({super.key});



  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(avatar),
        ),
        Padding(
            padding:const EdgeInsets.only(left: 26),
            child: Column(
              children: <Widget>[
                Text(role!,
                  style:  GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,)
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text("Nhân viên",
                    style:  GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,)
                    ),
                ),
                )
              ],
            )
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Padding(padding:const EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: IconButton(
                  onPressed: () {
                    // Get.to(const EditProfile());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  icon: const Icon(Icons.edit,
                    size: 45 ,
                  )
              ),
            ),
          ),
        )
      ],
    );
  }

}

class Profile extends StatelessWidget{
  Profile({super.key});


  @override
  Widget build(BuildContext context) {

    return Padding(
        padding:const EdgeInsets.only(top: 40),
        child: Container(
            width: double.maxFinite,
            height: 250,
            decoration: const BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Padding(padding: EdgeInsets.only(bottom: 20),
                    child: Text("Họ và tên: ${name}",
                      style:  GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,)
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20),
                    child: Text("Ngày sinh: ${dateOfBirth}",
                      style:  GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,)
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20),
                    child: Text("Số điện thoại: ${username}",
                      style:  GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,)
                    ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20),
                    child: Text("Giới tính: ${sex}",
                      style:  GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,)
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20),
                    child: Text("Địa chỉ: ${address}",
                      style:  GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,)
                      ),
                    ),
                  ),
                ],
              ),
            )

        )
    );
  }

}

// class Buttons extends StatelessWidget{
//   const Buttons({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: EdgeInsets.only(top: 66),
//       child: Column(
//         children: [
//           SizedBox(
//             width: double.maxFinite,
//             height: 54,
//             child: TextButton(
//                 onPressed: (){},
//                 style: TextButton.styleFrom(
//                   backgroundColor: Color.fromRGBO(73, 47, 44, 1),
//                 ),
//                 child: const Text('Đổi mật khẩu',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     )
//                 )
//             ),
//           ),
//            Padding(padding:const EdgeInsets.only(top: 30),
//               child: SizedBox(
//                   width: double.maxFinite,
//                   height: 54,
//                   child: TextButton(
//                   onPressed: (){
//
//
//                   },
//                   style: TextButton.styleFrom(
//                     backgroundColor: const Color.fromRGBO(73, 47, 44, 1),
//                   ),
//                   child: const Text('Đăng xuất',
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       )
//                   )
//               ),
//            )
//           ),
//         ],
//       ),
//     );
//   }
// }







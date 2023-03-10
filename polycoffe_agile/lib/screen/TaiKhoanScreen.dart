import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/constants.dart';
import 'package:polycoffe_agile/screen/DangNhapScreen.dart';
import 'package:polycoffe_agile/screen/EditProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'changepasswordscreen.dart';

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
  SharedPreferences? logindata ;
  String? avatar = "https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/default-avatar.png" ;
  String? username ="";
  String? name ="";
  String? role ="";
  String? sex ="" ;
  String? dateOfBirth ="" ;
  String? address ="";
  @override
  void initState() {
    super.initState();
    initial();
  }

   Future<void> initial() async {
     logindata = await SharedPreferences.getInstance();
     setState(() {
       avatar = logindata!.getString("avatar")!;
       username = logindata!.getString("username")!;
       name = logindata!.getString("name")!;
       role = logindata!.getString("role")!;
       sex = logindata!.getString("sex")!;
       dateOfBirth = logindata!.getString("dateOfBirth")!;
       address = logindata!.getString("address")!;
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
                  Avatar(avatar: avatar,role: role,),
                  Profile(username: username,name: name,sex: sex,dateOfBirth: dateOfBirth,address: address),
                  Padding(
                    padding: EdgeInsets.only(top: 66),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 54,
                          child: TextButton(
                              onPressed: (){
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Color.fromRGBO(73, 47, 44, 1),
                              ),
                              child: const Text('?????i m???t kh???u',
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
                                    logindata!.setBool("login", true);
                                    logindata!.clear();
                                    //Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MyLogin()));
                                    Get.off(MyLogin());

                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(73, 47, 44, 1),
                                  ),
                                  child: const Text('????ng xu???t',
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



class Avatar extends StatelessWidget{
  Avatar({super.key, required this.avatar, required this.role});

String? avatar,role;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(avatar!),
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
                // Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                //   child: Text("Nh??n vi??n",
                //     style:  GoogleFonts.inter(
                //         textStyle: const TextStyle(
                //           fontSize: 30,
                //           fontWeight: FontWeight.w400,)
                //     ),
                // ),
                // )
              ],
            )
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Padding(padding:const EdgeInsets.fromLTRB(0, 0, 0, 18),
              child: IconButton(
                  onPressed: () {
                     Get.to(EditProfile());
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                   // Get.bottomSheet(EditProfile());
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
  Profile({super.key, required this.username,required this.name,required this.dateOfBirth,required this.sex,required this.address,});

String? username,name,dateOfBirth,sex,address;
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
                    child: Text("H??? v?? t??n: ${name}",
                      style:  GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,)
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20),
                    child: Text("Ng??y sinh: ${dateOfBirth}",
                      style:  GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,)
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20),
                    child: Text("S??? ??i???n tho???i: ${username}",
                      style:  GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,)
                    ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20),
                    child: Text("Gi???i t??nh: ${sex}",
                      style:  GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,)
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20),
                    child: Text("?????a ch???: ${address}",
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
//                 child: const Text('?????i m???t kh???u',
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
//                   child: const Text('????ng xu???t',
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







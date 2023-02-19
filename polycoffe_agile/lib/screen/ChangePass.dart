import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ChangePass extends StatelessWidget{
//   final TextEditingController oldPass = TextEditingController();
//   final TextEditingController newPass = TextEditingController();
//   final TextEditingController rePass = TextEditingController();
//   Future<SharedPreferences> login = SharedPreferences.getInstance();
//   String password = login.getString()
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 28),
//                   child: TextField(
//                     controller: nametxt,
//                     style: GoogleFonts.inter(),
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Name',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//     );
//
//   }
// }

class ChangePass extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<ChangePass> {
  final TextEditingController oldPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();
  final TextEditingController rePass = TextEditingController();
  SharedPreferences? login;
  String? pass;
  @override
  void initState() {

    super.initState();
  }
  Future<void> init() async {
    login = await SharedPreferences.getInstance();
    setState(() {
      pass = login!.getString('password');

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroundCoffee.png'),
              fit: BoxFit.fill
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20,70,20,0),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: TextField(
                  controller: oldPass,
                  style: GoogleFonts.inter(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập mật khẩu cũ',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: TextField(
                  controller: newPass,
                  style: GoogleFonts.inter(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập mật khẩu mới',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: TextField(
                  controller: rePass,
                  style: GoogleFonts.inter(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập lại mật khẩu mới',
                  ),
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: (){
                      // Thực hiện đổi mật khẩu ở đây
                    },
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

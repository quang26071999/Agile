import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/Screen/TaiKhoanScreen.dart';
import 'package:polycoffe_agile/constants.dart';
import 'package:polycoffe_agile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';


class EditProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditScreen(),
    );
  }

}
class EditScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => EditScreenState();

}
class EditScreenState extends State<EditScreen>{
  SharedPreferences? logindata ;
  String? avatar;
  String? username ;
  String? name ;
  String? role;
  String? sex ;
  String? dateOfBirth ;
  String? address;
  int? gt;
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
      gt = sex == 'Nam' ? 0 : 1;
    });
  }

  final TextEditingController numberPhonetxt = TextEditingController();
  final TextEditingController nametxt = TextEditingController();
  final TextEditingController dateOfBirthtxt = TextEditingController();
  final TextEditingController addresstxt = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    numberPhonetxt.text = username.toString();
    nametxt.text = name.toString() ;
    dateOfBirthtxt.text = dateOfBirth.toString();
    addresstxt.text = address.toString();

    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color:  color),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28),
                      child: TextField(
                        controller: numberPhonetxt,
                        style: GoogleFonts.inter(),
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Number Phone',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28),
                      child: TextFormField(
                        controller: nametxt,
                        style: GoogleFonts.inter(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Vui lòng không để trống";
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 28),
                      child: TextFormField(
                        controller: dateOfBirthtxt,
                        style: GoogleFonts.inter(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Date of birth',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Vui lòng không để trống";
                          }
                          if(!RegExp(r'^(0[1-9]|[12][0-9]|[3][01])/(0[1-9]|1[012])/[0-9]{4}$').hasMatch(value!)){
                            return "Ngày sinh không đúng định dạng";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Expanded(
                        child: ListTile(
                          title: const Text('Nam'),
                          leading: Radio<int>(
                            value: 0,
                            groupValue: gt,
                            onChanged: (value) {
                              setState(() {
                                gt =value;
                                print(value);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Nữ'),
                          leading: Radio<int>(
                            value: 1,
                            groupValue: gt,
                            onChanged: (value) {
                              setState(() {
                                gt =value;
                                print(value);
                              });
                            },
                          ),
                        ),
                      ),
                    ]
                ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28),
                      child: TextField(
                        controller: addresstxt,
                        style: GoogleFonts.inter(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Address',
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 152,
                          padding: const EdgeInsets.fromLTRB(0,0,24,24),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown),
                              child: Text("LƯU",
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700))),
                              onPressed: () {
                                if(_formKey.currentState!.validate()){
                                  gt == 1 ? sex = 'Nữ': sex ='Nam';
                                  var documentRefence = FirebaseFirestore
                                      .instance
                                      .collection("User").doc(username);


                                  documentRefence.update({
                                    "hoTen" : nametxt.text,
                                    'gioiTinh': sex.toString(),
                                    "diaChi" : addresstxt.text,
                                    "ngaySinh" : dateOfBirthtxt.text,

                                    // "gioiTinh" : '$default_gioiTinh'

                                  }).then((value) =>
                                      Get.snackbar("Successfully", "Đổi thông tin thành công"))
                                      .catchError((error) => debugPrint("Sửa thất bại"));

                                 // Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => ProfileScreen()));
                                  setState(() {
                                    print(sex.toString());
                                    logindata!.setString("name", nametxt.text)!;
                                    // logindata!.setString("role", role.text)!;
                                    logindata!.setString("sex",sex.toString());
                                    logindata!.setString("dateOfBirth", dateOfBirthtxt.text)!;
                                    logindata!.setString("address", addresstxt.text)!;

                                    name = logindata!.getString("name")!;
                                    // sex = logindata!.getString("sex")!;
                                    dateOfBirth = logindata!.getString("dateOfBirth")!;
                                    address = logindata!.getString("address")!;
                                  });
                                  if(role == 'Admin'){
                                    Get.off(MyStatefulWidget(selectIndex: 4));
                                  }else Get.off(MyStatefulWidget(selectIndex: 1));

                                }
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 24),
                          width: 128,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown),
                              child: Text("HỦY",
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700))),
                              onPressed: ()
                              {
                                if(role == 'Admin'){
                                  Get.off(MyStatefulWidget(selectIndex: 4));
                                }else Get.off(MyStatefulWidget(selectIndex: 1));
                              }),
                        )
                      ],
                    )


                  ],
                ),
              ),
            ),
          )),
    );
  }
}








// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/models/user.dart';

class QLNVScreen extends StatelessWidget {
  QLNVScreen({super.key});

  // List ChucVu = ["Nhân viên", "Nhân viên", "Admin", "Nhân viên", "Admin"];
  // List HoTen = ["Phùng Văn Hiển", "Thế Hùng", "Nguyễn Văn Quang", "Thế Hùng", "Nguyễn Văn Quang"];
  // List Username = ["phunghien", "thehung", "nguyenquang", "thehung", "nguyenquang"];
  // List Birthday = ["20-12-1998", "1-1-2001", "1-1-1999", "1-1-2001", "1-1-1999"];
  // List Password = ["1234", "1234", "1234", "1234", "1234"];
  // List GioiTinh = ["Nam", "Nam", "Nam", "Nam", "Nam"];
  // List DiaChi = ["Nam Định", "Thanh Hóa", "Hải Dương", "Thanh Hóa", "Hải Dương"];
  // List SDT = ["023024242", "03462632", "034734723", "03462632", "034734723"];

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController hoTen = TextEditingController();
  final TextEditingController diaChi = TextEditingController();
  final TextEditingController ngaySinh = TextEditingController();
  final TextEditingController phone = TextEditingController();


  int _chucVuValue = 1;
  int _gioiTinhValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text('QLNV'),
      // ),
      body: Container(
          width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(

            image: AssetImage("assets/images/backgroundCoffee.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(

          minimum: const EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: SingleChildScrollView(
            child: Column(

              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffffffff),
                        suffixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        hintText: "Tìm nhân viên",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(),
                        )),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("User").snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index){
                            DocumentSnapshot documentSnapshot = snapshot.data?.docs[index]  as DocumentSnapshot<Object?>;

                            return Container(
                              width: MediaQuery.of(context).size.width ,
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: Card(
                                color: const Color(0xffDECDB9),
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      width: 56,
                                      height: 56,
                                      child: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://www.w3schools.com/howto/img_avatar.png"),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(10, 16, 10, 16),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(bottom: 20.0),
                                              child: Text(
                                                "Chức vụ: " + documentSnapshot["role"].toString(),
                                                style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w500)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(bottom: 20.0),
                                              child: Text(

                                                  "Username: " + documentSnapshot["username"],
                                                  style: GoogleFonts.inter(
                                                      textStyle: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w500))),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(bottom: 20.0),
                                              child: Text(

                                                  "Password: " + documentSnapshot["password"],
                                                  style: GoogleFonts.inter(
                                                      textStyle: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w500))),
                                            ),
                                            Text("Địa chỉ: " + documentSnapshot["diaChi"],
                                                style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight.w500))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 16, 2, 16),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(bottom: 20.0),
                                              child: Text(
                                                  "Họ và tên: " + documentSnapshot["hoTen"],
                                                  style: GoogleFonts.inter(
                                                      textStyle: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w500))),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(bottom: 20.0),
                                              child: Text(
                                                  "Ngày sinh: " + documentSnapshot["ngaySinh"],
                                                  style: GoogleFonts.inter(
                                                      textStyle: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w500))),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(bottom: 20.0),
                                              child: Text(
                                                  "Giới tính: " + documentSnapshot["gioiTinh"].toString(),
                                                  style: GoogleFonts.inter(
                                                      textStyle: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w500))),
                                            ),

                                            Text(
                                                "Số điện thoại: " + documentSnapshot["phone"].toString(),
                                                style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight.w500))
                                            ),

                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }

                      );
                    }
                    return Text("Chưa có nhân viên");
                  }
                )
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff492F2C),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return FractionallySizedBox(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    height: 750.0,
                    color: const Color(0xffDECDB9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 72,
                          icon: const Icon(Icons.add_a_photo),
                          onPressed: () {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              //padding: const EdgeInsets.only(right: 80.0),
                              child: (Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: _chucVuValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _chucVuValue = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    // padding:
                                    // const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                        "Admin",
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400))
                                    ),
                                  ),
                                ],
                              )),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: _chucVuValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _chucVuValue = value!;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                      "Nhân viên",
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400))
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 21, 0, 13),
                          child: TextFormField(
                            controller: username,
                            decoration: const InputDecoration(
                              //filled: true,
                              //fillColor: Color(0xffffffff),
                              border: OutlineInputBorder(),
                              prefixIcon: SizedBox(
                                  width: 50,
                                  child: Icon(
                                      Icons.supervised_user_circle_outlined)),
                              hintText: 'Nhập username',
                            ),
                            onChanged: (value) => {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: TextFormField(
                            controller: password,
                            decoration: const InputDecoration(
                              //filled: true,
                             // fillColor: Color(0xffffffff),
                              border: OutlineInputBorder(),
                              prefixIcon: SizedBox(
                                  width: 50, child: Icon(Icons.lock_open)),
                              hintText: 'Nhập password',
                            ),
                            onChanged: (value) => {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 17),
                          child: TextFormField(
                            controller: hoTen,
                            decoration: const InputDecoration(
                              //filled: true,
                              //fillColor: Color(0xffffffff),
                              border: OutlineInputBorder(),
                              prefixIcon: SizedBox(
                                  width: 50,
                                  child:
                                      Icon(Icons.supervised_user_circle_sharp)),
                              hintText: 'Nhập họ tên',
                            ),
                            onChanged: (value) => {},
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              "Giới tính: ",
                              style: TextStyle(fontSize: 16),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 70.0),
                              child: (Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: _gioiTinhValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _gioiTinhValue = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  const Text(
                                    "Nam",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: _gioiTinhValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _gioiTinhValue = value!;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                const Text(
                                  "Nữ",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 13),
                          child: TextFormField(
                            controller: ngaySinh,
                            decoration: const InputDecoration(
                              //filled: true,
                              //fillColor: Color(0xffffffff),
                              border: OutlineInputBorder(),
                              prefixIcon: SizedBox(
                                  width: 50,
                                  child: Icon(Icons.calendar_month_outlined)),
                              hintText: 'Nhập ngày sinh',
                            ),
                            onChanged: (value) => {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: TextFormField(
                            controller: diaChi,
                            decoration: const InputDecoration(
                              //filled: true,
                              //fillColor: Color(0xffffffff),
                              border: OutlineInputBorder(),
                              prefixIcon: SizedBox(
                                  width: 50, child: Icon(Icons.map_outlined)),
                              hintText: 'Nhập địa chỉ',
                            ),
                            onChanged: (value) => {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                          child: TextFormField(
                            controller: phone,
                            decoration: const InputDecoration(
                              //filled: true,
                             // fillColor: Color(0xffffffff),
                              border: OutlineInputBorder(),
                              prefixIcon:
                                  SizedBox(width: 50, child: Icon(Icons.phone)),
                              hintText: 'Nhập số điện thoại',
                            ),
                            onChanged: (value) => {},
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 152,
                              padding: const EdgeInsets.only(right: 24),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.brown),
                                  child: Text(
                                      "LƯU",
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700))
                                  ),
                                  onPressed: () {
                                    var documentRefence = FirebaseFirestore.instance.collection("User");

                                    User user = User(username.text, password.text, hoTen.text, 1, 2, diaChi.text, "2333", ngaySinh.text, int.parse(phone.text.toString()));

                                    documentRefence.add(user.toJson()).whenComplete(() => {
                                      Navigator.pop(context)
                                    })
                                    .then((value) =>
                                    debugPrint("Thêm thành công"))
                                    .catchError((error) =>
                                    debugPrint("Thêm thất bại ${error}"));

                                  }),
                            ),
                            Container(
                              width: 128,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.brown),
                                  child: Text(
                                      "HỦY",
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700))
                                  ),
                                  onPressed: () => Navigator.pop(context)),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
                });
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

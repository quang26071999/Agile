// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polycoffe_agile/models/user.dart';

class RoleChoice {
  String roleChoice;
  int index;

  RoleChoice({required this.index, required this.roleChoice});
}

class GioiTinhChoice {
  String gioiTinhChoice;
  int indexGT;

  GioiTinhChoice({required this.indexGT, required this.gioiTinhChoice});
}

class QLNVScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: QLNV(),
   );
  }
}

class QLNV extends StatefulWidget{
  @override
  _QLNVState createState() =>
    _QLNVState();


}
class _QLNVState extends State<QLNV>{
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController hoTen = TextEditingController();
  final TextEditingController diaChi = TextEditingController();
  final TextEditingController ngaySinh = TextEditingController();


  final TextEditingController usernameUpdate = TextEditingController();
  final TextEditingController passwordUpdate = TextEditingController();
  final TextEditingController hoTenUpdate = TextEditingController();
  final TextEditingController diaChiUpdate = TextEditingController();
  final TextEditingController ngaySinhUpdate = TextEditingController();



  String default_role = "Admin";
  int default_index_role = 0;
  List<RoleChoice> _listRole = [
    RoleChoice(index: 0, roleChoice: "Admin"),
    RoleChoice(index: 1, roleChoice: "Nhân viên")
  ];

  String default_gioiTinh = "Nam";
  int default_index_gioiTinh = 1;
  List<GioiTinhChoice> _listGT = [
    GioiTinhChoice(indexGT: 0, gioiTinhChoice: "Nam"),
    GioiTinhChoice(indexGT: 1, gioiTinhChoice: "Nữ"),
  ];

  String id = DateTime.now().microsecond.toString();

  File? avatarFile;
  final ImagePicker _imagePicker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  String search = "";


  late bool _passVisible;
  @override
  void initState() {
    _passVisible = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text('QLNV'),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundCoffee.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.fromLTRB(10, 40, 10, 0),
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
                      )
                  ),
                  onChanged: (val){
                    setState((){
                      search = val;
                    });
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("User").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting && snapshot.hasData != true) {
                        return const Center(
                          child: CircularProgressIndicator(

                          ),
                        );
                      }else{
                        return  ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.docs.where((element) => element["hoTen"].toString().toLowerCase().contains(search.toLowerCase()) || element["username"].toString().startsWith(search)).length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot documentSnapshot = snapshot.data
                                  ?.docs.where((element) => element["hoTen"].toString().toLowerCase().contains(search.toLowerCase()) || element["username"].toString().startsWith(search)).elementAt(index) as DocumentSnapshot<Object?>;
                              String id = documentSnapshot.id;
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                const EdgeInsets.symmetric(vertical: 15.0),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          backgroundColor:
                                          const Color(0xffDECDB9),
                                          icon: Icons.edit,
                                          onPressed: (context) {
                                            usernameUpdate.text = documentSnapshot["username"].toString();
                                            passwordUpdate.text = documentSnapshot["password"];
                                            hoTenUpdate.text = documentSnapshot["hoTen"];
                                            diaChiUpdate.text = documentSnapshot["diaChi"];
                                            ngaySinhUpdate.text = documentSnapshot["ngaySinh"];

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
                                                        child: Form(
                                                          key: _formKey,
                                                          child: SingleChildScrollView(
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                                              //height: 750.0,
                                                              color: const Color(0xffDECDB9),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [

                                                                  Padding(
                                                                      padding: const EdgeInsets.only(top: 22),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .only(
                                                                                bottom: 44),
                                                                            child: Image.network(documentSnapshot["avatar"], width: 100, height: 100,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),

                                                                  Container(
                                                                      child: Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        //mainAxisAlignment: MainAxisAlignment.end,
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: _listRole
                                                                            .map((data) => Container(
                                                                          height: 50,
                                                                          width: 150,
                                                                          child: RadioListTile(
                                                                              title: Text('${data.roleChoice}',
                                                                                  style: GoogleFonts.inter(
                                                                                      textStyle:
                                                                                      const TextStyle(
                                                                                          fontSize: 18,
                                                                                          fontWeight:
                                                                                          FontWeight
                                                                                              .w400))),
                                                                              value: data.index,
                                                                              groupValue: default_index_role,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  default_role =
                                                                                      data.roleChoice;
                                                                                  default_index_role =
                                                                                      data.index;
                                                                                });
                                                                              }),
                                                                        ))
                                                                            .toList(),
                                                                      )),
                                                                  Padding(
                                                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                                                                    child: TextFormField(
                                                                      keyboardType: TextInputType.number,
                                                                      controller: usernameUpdate,
                                                                      decoration: const InputDecoration(
                                                                        //filled: true,
                                                                        //fillColor: Color(0xffffffff),
                                                                        border: OutlineInputBorder(),
                                                                        prefixIcon: SizedBox(
                                                                            width: 50,
                                                                            child: Icon(
                                                                                Icons.supervised_user_circle_outlined)),
                                                                        hintText: 'Nhập username(số điện thoại)',
                                                                      ),
                                                                      validator: (value){
                                                                        if(value!.isEmpty){
                                                                          return "Vui lòng không để trống";
                                                                        }
                                                                        else if(!RegExp(r'^(84|0)+([0-9]{9})+$').hasMatch(value!)){
                                                                          return "Nhập đúng định dạng số điện thoại";
                                                                        }
                                                                        return null;
                                                                      },

                                                                      onChanged: (value) => {},
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                      padding: const EdgeInsets.only(bottom: 14),
                                                                      child: TextFormField(
                                                                        obscureText: !_passVisible,
                                                                        controller: passwordUpdate,
                                                                        decoration: InputDecoration(
                                                                          //filled: true,
                                                                          // fillColor: Color(0xffffffff),
                                                                          border: OutlineInputBorder(),
                                                                          prefixIcon: SizedBox(
                                                                              width: 50, child: Icon(Icons.lock_open)),
                                                                          hintText: 'Nhập password',
                                                                        ),

                                                                        validator: (value){
                                                                          if(value!.isEmpty){
                                                                            return "Vui lòng không để trống";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        onChanged: (value) => {},

                                                                      )
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(bottom: 0),
                                                                    child: TextFormField(
                                                                      controller: hoTenUpdate,
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
                                                                      validator: (value){
                                                                        if(value!.isEmpty){
                                                                          return "Vui lòng không để trống";
                                                                        }
                                                                        else{
                                                                          return null;
                                                                        }
                                                                      },
                                                                      onChanged: (value) => {},
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    children: [
                                                                      Container(
                                                                          padding: EdgeInsets.symmetric(vertical: 14),
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                            mainAxisSize: MainAxisSize.max,
                                                                            children: _listGT
                                                                                .map((data) => Container(
                                                                              height: 50,
                                                                              width: 130,
                                                                              child: RadioListTile(
                                                                                  title: Text(
                                                                                      '${data.gioiTinhChoice}',
                                                                                      style: GoogleFonts.inter(
                                                                                          textStyle: const TextStyle(
                                                                                              fontSize: 16,
                                                                                              fontWeight:
                                                                                              FontWeight
                                                                                                  .w400))),
                                                                                  value: data.indexGT,
                                                                                  groupValue:
                                                                                  default_index_gioiTinh,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      default_gioiTinh = data
                                                                                          .gioiTinhChoice;
                                                                                      default_index_gioiTinh =
                                                                                          data.indexGT;
                                                                                    });
                                                                                  }),
                                                                            ))
                                                                                .toList(),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                                                                    child: TextFormField(
                                                                      controller: ngaySinhUpdate,
                                                                      decoration: const InputDecoration(
                                                                        //filled: true,
                                                                        //fillColor: Color(0xffffffff),
                                                                        border: OutlineInputBorder(),
                                                                        prefixIcon: SizedBox(
                                                                            width: 50,
                                                                            child: Icon(Icons.calendar_month_outlined)),
                                                                        hintText: 'Nhập ngày sinh',
                                                                      ),
                                                                      // validator: (value){
                                                                      //   if(value!.isEmpty){
                                                                      //     return "Vui lòng không để trống";
                                                                      //   }
                                                                      //   if(!RegExp(r'^(0[1-9]|[12][0-9]|[3][01])/(0[1-9]|1[012])/[0-9]{4}$').hasMatch(value!)){
                                                                      //     return "Ngày sinh không đúng định dạng";
                                                                      //   }
                                                                      //   else{
                                                                      //     return null;
                                                                      //   }
                                                                      // },
                                                                      onChanged: (value) => {},
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(bottom: 14),
                                                                    child: TextFormField(
                                                                      controller: diaChiUpdate,
                                                                      decoration: const InputDecoration(
                                                                        //filled: true,
                                                                        //fillColor: Color(0xffffffff),
                                                                        border: OutlineInputBorder(),
                                                                        prefixIcon: SizedBox(
                                                                            width: 50, child: Icon(Icons.map_outlined)),
                                                                        hintText: 'Nhập địa chỉ',
                                                                      ),
                                                                      // validator: (value){
                                                                      //   if(value!.isEmpty){
                                                                      //     return "Vui lòng không để trống";
                                                                      //   }
                                                                      //   else{
                                                                      //     return null;
                                                                      //   }
                                                                      // },
                                                                      onChanged: (value) => {},
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
                                                                                var documentRefence = FirebaseFirestore
                                                                                    .instance
                                                                                    .collection("User").doc(id);


                                                                                documentRefence.update({
                                                                                  "username" : usernameUpdate.text,
                                                                                  "password" : passwordUpdate.text,
                                                                                  "hoTen" : hoTenUpdate.text,
                                                                                  "diaChi" : diaChiUpdate.text,
                                                                                  "ngaySinh" : ngaySinhUpdate.text,
                                                                                  "role" : '$default_role',
                                                                                  "gioiTinh" : '$default_gioiTinh'

                                                                                }).then((value) =>
                                                                                    Get.snackbar("Thông báo", "Sửa thông tin thành công"))
                                                                                    .catchError((error) => debugPrint("Sửa thất bại"));

                                                                                Navigator.pop(context);
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
                                                                            onPressed: () => {

                                                                              Navigator.pop(context)}),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ));
                                                  });
                                                });



                                          }),
                                      SlidableAction(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          backgroundColor:
                                          const Color(0xffDECDB9),
                                          icon: Icons.delete_forever,
                                          onPressed: (context) {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    insetPadding: EdgeInsets.zero,
                                                    title: const Text(
                                                      'Xoá nhân viên',
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    content: Text(
                                                        'Bạn có muốn xoá ${documentSnapshot["hoTen"]} không ?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () async {
                                                          Navigator.pop(context);

                                                          var storageRef = FirebaseStorage.instance
                                                              .ref().child('${documentSnapshot['username']}');
                                                          storageRef.delete();

                                                          DocumentReference
                                                          documentReference =
                                                          FirebaseFirestore.instance
                                                              .collection("User")
                                                              .doc(id);
                                                          documentReference
                                                              .delete()
                                                              .whenComplete(() =>
                                                          {Navigator.pop(context)})
                                                              .then((value) => debugPrint(
                                                              "Xoá thành công"))
                                                              .catchError((error) => debugPrint(
                                                              "Xoá thất bại ${error}"));
                                                        },
                                                        child: const Text(
                                                          'Xoá', //title
                                                          textAlign:
                                                          TextAlign.end, //aligment
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text(
                                                          'Huỷ', //title
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            );

                                          })
                                    ],
                                  ),
                                  child: Card(
                                    color: const Color(0xffDECDB9),
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 78,
                                          height: 56,
                                          child: CircleAvatar(
                                            radius: 150,
                                            child: ClipOval(
                                              child: Image.network(documentSnapshot["avatar"],
                                                  fit: BoxFit.cover,
                                                  width: 56,
                                                  height: 56,

                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 26, 10, 26),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      bottom: 20.0),
                                                  child: Text(
                                                    "Chức vụ: " +
                                                        documentSnapshot[
                                                        "role"],
                                                    style: GoogleFonts.inter(
                                                        textStyle:
                                                        const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      bottom: 20.0),
                                                  child: Text(
                                                      "Username: " +
                                                          documentSnapshot[
                                                          "username"]
                                                              .toString(),
                                                      style: GoogleFonts.inter(
                                                          textStyle:
                                                          const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500))),
                                                ),
                                                Text(
                                                    "Họ và tên: " +
                                                        documentSnapshot[
                                                        "hoTen"],
                                                    style: GoogleFonts.inter(
                                                        textStyle:
                                                        const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500))),

                                                // Padding(
                                                //   padding:
                                                //   const EdgeInsets.only(bottom: 20.0),
                                                //   child: Text(
                                                //
                                                //       "Password: " + documentSnapshot["password"],
                                                //       style: GoogleFonts.inter(
                                                //           textStyle: const TextStyle(
                                                //               fontSize: 10,
                                                //               fontWeight:
                                                //               FontWeight.w500))),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 26, 13, 26),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      bottom: 20.0),
                                                  child: Text(
                                                      "Ngày sinh: " +
                                                          documentSnapshot[
                                                          "ngaySinh"],
                                                      style: GoogleFonts.inter(
                                                          textStyle:
                                                          const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500))),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      bottom: 20.0),
                                                  child: Text(
                                                      "Địa chỉ: " +
                                                          documentSnapshot[
                                                          "diaChi"],
                                                      style: GoogleFonts.inter(
                                                          textStyle:
                                                          const TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500))),
                                                ),
                                                Text(
                                                    "Giới tính: " +
                                                        documentSnapshot[
                                                        "gioiTinh"],
                                                    style: GoogleFonts.inter(
                                                        textStyle:
                                                        const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500))),
                                                // Text(
                                                //     "Số điện thoại: " + documentSnapshot["phone"].toString(),
                                                //     style: GoogleFonts.inter(
                                                //         textStyle: const TextStyle(
                                                //             fontSize: 10,
                                                //             fontWeight:
                                                //             FontWeight.w500))
                                                // ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });

                      }
                      return Text("Chưa có nhân viên");
                    }),
              )
            ],
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
                  return SingleChildScrollView(
                    child: FractionallySizedBox(
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 40.0),
                              //height: 750.0,
                              color: const Color(0xffDECDB9),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(
                                  //   iconSize: 72,
                                  //   icon: const Icon(Icons.add_a_photo),
                                  //   onPressed: () {},
                                  // ),
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 26),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 70),
                                            child: avatarFile == null
                                                ? const SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: Image(
                                                    image: AssetImage(
                                                        'assets/images/imageDefaut.png')))
                                                : Image.file(
                                              avatarFile!,
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 14, top: 80),
                                            child: IconButton(
                                              iconSize: 30,
                                              icon: const Icon(Icons.add_circle),
                                              onPressed: () async {
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return SizedBox(
                                                      height: 130,
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            ListTile(
                                                              leading: const Icon(
                                                                Icons.photo_camera,
                                                              ),
                                                              title: const Text(
                                                                'Camera',
                                                                style: TextStyle(),
                                                              ),
                                                              onTap: () async {
                                                                final XFile? image =
                                                                await _imagePicker
                                                                    .pickImage(
                                                                    source:
                                                                    ImageSource
                                                                        .camera,
                                                                    imageQuality:
                                                                    10);
                                                                setState(() {
                                                                  avatarFile =
                                                                      File(image!.path);
                                                                });
                                                                Navigator.of(context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            ListTile(
                                                              leading: const Icon(
                                                                Icons.camera,
                                                              ),
                                                              title: const Text(
                                                                'Bộ sưu tập',
                                                                style: TextStyle(),
                                                              ),
                                                              onTap: () async {
                                                                final XFile? image =
                                                                await _imagePicker
                                                                    .pickImage(
                                                                    source: ImageSource
                                                                        .gallery);
                                                                setState(() {
                                                                  avatarFile =
                                                                      File(image!.path);
                                                                });
                                                                Navigator.of(context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      )),

                                  Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        //mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: _listRole
                                            .map((data) => Container(
                                          height: 50,
                                          width: 150,
                                          child: RadioListTile(
                                              title: Text('${data.roleChoice}',
                                                  style: GoogleFonts.inter(
                                                      textStyle:
                                                      const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400))),
                                              value: data.index,
                                              groupValue: default_index_role,
                                              onChanged: (value) {
                                                setState(() {
                                                  default_role =
                                                      data.roleChoice;
                                                  default_index_role =
                                                      data.index;
                                                });
                                              }),
                                        ))
                                            .toList(),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 21, 0, 14),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: username,
                                      decoration: const InputDecoration(
                                        //filled: true,
                                        //fillColor: Color(0xffffffff),
                                        border: OutlineInputBorder(),
                                        prefixIcon: SizedBox(
                                            width: 50,
                                            child: Icon(
                                                Icons.supervised_user_circle_outlined)),
                                        hintText: 'Nhập username(số điện thoại)',
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
                                      onChanged: (value) => {},
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 14),
                                      child: TextFormField(
                                        obscureText: !_passVisible,
                                        controller: password,
                                        decoration: const InputDecoration(
                                          //filled: true,
                                          // fillColor: Color(0xffffffff),
                                          border: OutlineInputBorder(),
                                          prefixIcon: SizedBox(
                                              width: 50, child: Icon(Icons.lock_open)),

                                          hintText: 'Nhập password',
                                        ),

                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Vui lòng không để trống";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) => {},

                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
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
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Vui lòng không để trống";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) => {},
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.symmetric(vertical: 14),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: _listGT
                                                .map((data) => Container(
                                              height: 50,
                                              width: 130,
                                              child: RadioListTile(
                                                  title: Text(
                                                      '${data.gioiTinhChoice}',
                                                      style: GoogleFonts.inter(
                                                          textStyle: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400))),
                                                  value: data.indexGT,
                                                  groupValue:
                                                  default_index_gioiTinh,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      default_gioiTinh = data
                                                          .gioiTinhChoice;
                                                      default_index_gioiTinh =
                                                          data.indexGT;
                                                    });
                                                  }),
                                            ))
                                                .toList(),
                                          )),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
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
                                      // validator: (value){
                                      //   if(value!.isEmpty){
                                      //     return "Vui lòng không để trống";
                                      //   }
                                      //   if(!RegExp(r'^(0[1-9]|[12][0-9]|[3][01])/(0[1-9]|1[012])/[0-9]{4}$').hasMatch(value!)){
                                      //     return "Ngày sinh không đúng định dạng";
                                      //   }
                                      //   else{
                                      //     return null;
                                      //   }
                                      // },
                                      onChanged: (value) => {},
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 14),
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
                                      // validator: (value){
                                      //   if(value!.isEmpty){
                                      //     return "Vui lòng không để trống";
                                      //   }
                                      //   else{
                                      //     return null;
                                      //   }
                                      // },
                                      onChanged: (value) => {},
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
                                            onPressed: ()  async {
                                              if(avatarFile == null){
                                                Get.snackbar("Thông báo", "Vui lòng thêm ảnh cho sản phẩm");
                                              }
                                              else if(_formKey.currentState!.validate() && avatarFile!= null){
                                                var storage = FirebaseStorage.instance.ref().child('/User/$id');
                                                try{
                                                  await storage.putFile(avatarFile!);
                                                }catch(err){
                                                  print('Error: $err');
                                                }
                                                var imgUrl = await storage.getDownloadURL();
                                                User user = User(
                                                    username.text.toString(),
                                                    password.text,
                                                    hoTen.text,
                                                    '$default_role',
                                                    '$default_gioiTinh',
                                                    diaChi.text,
                                                    imgUrl,
                                                    ngaySinh.text);
                                                final documentRefence = FirebaseFirestore
                                                    .instance
                                                    .collection("User").doc(username.text);
                                                documentRefence
                                                    .set(user.toJson())
                                                    .whenComplete(
                                                        () => {
                                                      setEmpty(),
                                                      Navigator.pop(context)})
                                                    .then((value) =>
                                                    Get.snackbar("Thành công", "Thêm nhân viên thành công")
                                                )
                                                    .catchError((error) =>
                                                    Get.snackbar("Error", "Thêm nhân viên thất bại")
                                                );
                                              }
                                            }),
                                      ),
                                      Container(
                                        width: 128,
                                        padding: EdgeInsets.only(bottom: 24),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.brown),
                                            child: Text("HỦY",
                                                style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w700))),
                                            onPressed: () => {
                                              setEmpty(),
                                              Navigator.pop(context)}),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  );
                });
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  Future<void> setEmpty() async {
    avatarFile = null;
    username.text = "";
    diaChi.text = "";
    password.text = "";
    hoTen.text = "";
    ngaySinh.text = "";

  }
}




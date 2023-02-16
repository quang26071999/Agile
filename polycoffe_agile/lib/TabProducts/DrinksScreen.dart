import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DrinksScreen extends StatelessWidget {
  DrinksScreen({super.key, required this.maLoai});

  final int maLoai;
  final TextEditingController _tenSPUpdateTED = TextEditingController();
  final TextEditingController _giaSPUpdateTED = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundCoffee.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                style: GoogleFonts.inter(
                    fontSize: 16, fontStyle: FontStyle.italic),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffFFFFFF),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    hintText: "Tìm kiếm",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(),
                    )),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Products")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 130),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs
                            .where((element) => element["maloai"] == maLoai)
                            .length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = snapshot
                              .data?.docs
                              .where((element) => element["maloai"] == maLoai)
                              .elementAt(index) as DocumentSnapshot<Object?>;
                          String id = documentSnapshot.id; // id
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Slidable(
                              // key: ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 1,
                                    borderRadius: BorderRadius.circular(15),
                                    onPressed: (context) {
                                      _tenSPUpdateTED.text =
                                          documentSnapshot["tensp"];
                                      _giaSPUpdateTED.text =
                                          documentSnapshot["gia"].toString();
                                      showModalBottomSheet<void>(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return FractionallySizedBox(
                                              heightFactor: 0.6,
                                              child: Container(
                                                color: const Color(0xffDECDB9),
                                                child: Center(
                                                  child: SingleChildScrollView(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            46),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      documentSnapshot[
                                                                          "hinhanh"],
                                                                  width: 100,
                                                                  height: 100,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            40,
                                                                        right:
                                                                            40),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              34.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            280,
                                                                        // height:
                                                                        //     40,
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              _tenSPUpdateTED,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(),
                                                                              hintText: 'Nhập tên sản phẩm cần sửa',
                                                                              isDense: true),
                                                                          validator:
                                                                              (text) {
                                                                            if (text == null ||
                                                                                text.isEmpty) {
                                                                              return 'Tên không được để trống';
                                                                            }
                                                                            return null;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          280,
                                                                      // height:
                                                                      //     40,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            _giaSPUpdateTED,
                                                                        decoration: const InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(),
                                                                            hintText:
                                                                                'Nhập giá sản phẩm cần sửa',
                                                                            isDense:
                                                                                true),
                                                                        validator:
                                                                            (text) {
                                                                          if (text == null ||
                                                                              text.isEmpty) {
                                                                            return 'Giá không được để trống';
                                                                          }
                                                                          if (int.parse(text) <=
                                                                              0) {
                                                                            return 'Vui lòng nhập giá sản phẩm > 0 đ';
                                                                          }
                                                                          return null;
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            46),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              24.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            128,
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(backgroundColor: const Color(0xff492F2C)),
                                                                          onPressed:
                                                                              () {
                                                                            if (_formKey.currentState!.validate()) {
                                                                              var documentReference = FirebaseFirestore.instance.collection("Products").doc(id);
                                                                              documentReference
                                                                                  .update({
                                                                                    "tensp": _tenSPUpdateTED.text,
                                                                                    "gia": _giaSPUpdateTED.text
                                                                                  })
                                                                                  .then((value) => debugPrint("Sửa thành công"))
                                                                                  .catchError((error) => debugPrint("Sửa thất bại:  ${error}"));
                                                                              Navigator.pop(context);
                                                                            }
                                                                            // print(snapshot.data?.docs.where((element) => element["maloai"] == maLoai).length) ;
                                                                          },
                                                                          child: Text(
                                                                              'LƯU',
                                                                              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffffffff))),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          128,
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                const Color(0xff492F2C)),
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                        child: Text(
                                                                            'HUỶ',
                                                                            style: GoogleFonts.inter(
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color(0xffffffff))),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    },
                                    backgroundColor: const Color(0xffDECDB9),
                                    foregroundColor: Colors.black,
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    flex: 1,
                                    borderRadius: BorderRadius.circular(15),
                                    onPressed: (BuildContext context) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          insetPadding: EdgeInsets.zero,
                                          title: const Text(
                                            'Xoá sản phẩm',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Text(
                                              'Bạn có muốn xoá ${documentSnapshot["tensp"]} không ?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                var storageRef = FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child(
                                                        '${documentSnapshot["masp"]}');
                                                await storageRef.delete();
                                                DocumentReference
                                                    documentReference =
                                                    FirebaseFirestore.instance
                                                        .collection("Products")
                                                        .doc(id);
                                                await documentReference
                                                    .delete()
                                                    .whenComplete(() => {
                                                          Navigator.pop(context)
                                                        })
                                                    .then((value) => debugPrint(
                                                        "Xoá thành công"))
                                                    .catchError((error) =>
                                                        debugPrint(
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
                                    },
                                    backgroundColor: const Color(0xffDECDB9),
                                    foregroundColor: Colors.black,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),

                              child: Card(
                                // margin: EdgeInsets.only(bottom: 20, top: 20),
                                color: const Color(0xffDECDB9),
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20, left: 24),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        documentSnapshot[
                                        "hinhanh"],
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 50),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Text(
                                                    documentSnapshot["tensp"],
                                                    textAlign: TextAlign.start,
                                                    style: GoogleFonts.inter(
                                                        color:
                                                            Color(0xff000000),
                                                        fontSize: 16,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Text(
                                                  NumberFormat.simpleCurrency(
                                                          locale: "vi_VN")
                                                      .format(int.parse(
                                                          documentSnapshot[
                                                                  "gia"]
                                                              .toString())),
                                                  textAlign: TextAlign.right,
                                                  style: GoogleFonts.inter(
                                                      color: Color(0xff000000),
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.italic))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ));
                  }
                  return const Text("Không có sản phẩm");
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}

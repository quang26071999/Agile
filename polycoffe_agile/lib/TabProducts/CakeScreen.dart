import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CakeScreen extends StatelessWidget {
  const CakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundCoffee.png"),
              fit: BoxFit.cover,
            ),
          ),

          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffFFFFFF),
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
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
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = snapshot
                              .data?.docs[index] as DocumentSnapshot<Object?>;

                          // lay id de xoa
                          String idDelete = documentSnapshot.id;

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Card(
                              color: const Color(0xffDECDB9),
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50.0),
                                    child: Image.memory(
                                      base64.decode(documentSnapshot["hinhanh"]),
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  Column(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          documentSnapshot["tensp"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                            documentSnapshot["gia"].toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic)),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      iconSize: 30,
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Text('Xoá sản phẩm'),
                                                content: Text(
                                                    'Bạn có muốn xoá sản phẩm ${documentSnapshot["tensp"]} không ?'),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        DocumentReference
                                                        documentReference =
                                                        FirebaseFirestore.instance
                                                            .collection(
                                                            "Products")
                                                            .doc(idDelete);
                                                        documentReference
                                                            .delete()
                                                            .whenComplete(() => {
                                                          debugPrint(
                                                              "Xoa thanh cong")
                                                        });
                                                      },
                                                      child: Text('Xoá')),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Huỷ'))
                                                ],
                                              ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Text("Không có sản phẩm");
                  },
                )
              ],
            ),
          ),
          ),
    );
  }
}

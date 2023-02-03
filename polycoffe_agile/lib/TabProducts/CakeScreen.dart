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
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Products").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                        snapshot.data?.docs[index] as DocumentSnapshot<Object?>;

                        // lay id de xoa
                        String idDelete= documentSnapshot.id;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                documentSnapshot["masp"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot["tensp"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot["gia"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                iconSize: 30,
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  DocumentReference documentReference = FirebaseFirestore.instance.collection("Products").doc(idDelete);
                                    documentReference.delete().whenComplete(() => {
                                      debugPrint("Xoa thanh cong")
                                    });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Text("Không có sản phẩm");
                },
              )
            ],
          )),
    );
  }
}
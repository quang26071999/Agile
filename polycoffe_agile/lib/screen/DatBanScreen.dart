import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/screen/MenuOrderScreen.dart';

CollectionReference colTable = FirebaseFirestore.instance.collection("Table");

class DatBanScreen extends StatefulWidget {
  const DatBanScreen({super.key});

  @override
  State<DatBanScreen> createState() => _DatBanScreenState();
}

class _DatBanScreenState extends State<DatBanScreen> {
  late String maBan, maHDT;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundCoffee.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("Table").snapshots(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      maBan = "${snapShot.data!.docs.length+1}";
                      return GridView.builder(
                          itemCount: snapShot.data?.docs.length,
                          padding:
                              const EdgeInsets.only(right: 20, left: 20, top: 20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 23,
                            crossAxisSpacing: 26,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {

                            DocumentSnapshot docSnap = snapShot.data?.docs[index]
                                as DocumentSnapshot<Object?>;
                            int docSnapX = snapShot.data!.docs.length;
                            String id = docSnap.id;
                            String status = docSnap['trangThai'];

                            if (docSnap["HDT"] != null) {
                              colTable
                                  .doc(id)
                                  .update({"trangThai": "Ch??a Thanh To??n"});
                            } else {
                              colTable.doc(id).update({"trangThai": "Tr???ng"});
                            }
                            String trangThai = docSnap["trangThai"];
                            return GestureDetector(
                                onLongPress: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Th??ng b??o'),
                                  content: const Text('B???n mu???n x??a b??n n??y'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        print(status);
                                        print(id);

                                          FirebaseFirestore.instance.collection("Table")
                                              .doc('${docSnapX}')
                                              .delete()
                                              .then((value) => {
                                                Get.snackbar('Th??nh c??ng', 'X??a th??nh c??ng')
                                          }
                                          );

                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuOrder(
                                                numTable: "B??n $id",
                                                idBan: id,
                                              )));
                                },
                                child: SizedBox(
                                  width: 147,
                                  height: 147,
                                  child: Card(
                                    color: const Color(0xffFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text(
                                                  style: GoogleFonts.inter(
                                                      fontSize: 24),
                                                  'B??n $id',
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: Text(
                                                  trangThai,
                                                  style: GoogleFonts.inter(
                                                    color: trangThai ==
                                                            "Ch??a Thanh To??n"
                                                        ? const Color(0xffFF0000)
                                                        : const Color(0xff0000FF),
                                                    fontSize: 16,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 5.0),
                                                  child: trangThai ==
                                                          "Ch??a Thanh To??n"
                                                      ? Container(
                                                        child: Image.asset(
                                                            'assets/images/coffee.png',
                                                            width: 70,
                                                            height: 70,
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                          ),
                                                      )
                                                      : Container(
                                                          child: Image.asset(
                                                            'assets/images/tableCoffee.png',
                                                            width: 70,
                                                            height: 70,
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                          ),
                                                        ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          });
                    } else {
                      return const Text("Kh??ng c?? b??n n??o");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff492F2C),
        onPressed: () {
          // setState(() {
          //   maBan = "B01${DateTime
          //       .now()
          //       .millisecondsSinceEpoch}";
          //   // maHDT = "HDTB01";
          //
          // });
          showAlert(context, maBan: maBan);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void showAlert(BuildContext context, {required maBan}) {
  Widget cancelButton = TextButton(
    child: Text("H???y",
        style: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.red)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Th??m",
        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400)),
    onPressed: () {
      colTable.doc(maBan).set({
        "maBan": maBan,
        "trangThai": "Tr???ng",
        "HDT": null,
      });
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "TH??NG B??O",
      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700),
    ),
    content: Text(
      "B???n ch???c ch???n mu???n th??m b??n?",
      style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic),
    ),
    backgroundColor: const Color(0xffDECDB9),
    actions: [
      continueButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

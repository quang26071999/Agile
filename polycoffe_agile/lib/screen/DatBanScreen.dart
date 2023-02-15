import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  // List trangThai = [
  //   "Chưa thanh toán",
  //   "Trống",
  //   "Chưa thanh toán",
  //   "Trống",
  //   "Chưa thanh toán",
  //   "Trống",
  // ];

  // List soBan = [1, 2, 3, 4, 5, 6];

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
              Container(
                alignment: Alignment.topRight,
                child: Row(
                  children: const [
                    Text(
                      "Lọc theo",
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Icon(
                      Icons.filter_alt_sharp,
                      size: 32,
                    )
                  ],
                ),
              ),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Table").snapshots(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    maBan =
                        "B0${(snapShot.data?.docs.length)}${DateTime.now().millisecondsSinceEpoch}";
                    return GridView.builder(
                        itemCount: snapShot.data?.docs.length,
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 60),
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
                          String trangThai = docSnap["trangThai"];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MenuOrder(numTable: "Bàn ${index + 1}")));
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
                                                "Bàn ${index + 1}",
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Text(
                                                trangThai,
                                                style: GoogleFonts.inter(
                                                  color: trangThai ==
                                                          "Chưa Thanh Toán"
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
                                                        "Chưa Thanh Toán"
                                                    ? Image.asset(
                                                        'assets/images/coffee.png',
                                                        width: 71,
                                                        height: 85,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                      )
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 16),
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
                    return const Text("Không có bàn nào");
                  }
                },
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
          colTable.doc(maBan).set({
            "maBan": maBan,
            "trangThai": "Trống",
            "maHDT": null,
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

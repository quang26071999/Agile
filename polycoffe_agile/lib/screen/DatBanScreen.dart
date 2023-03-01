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

  // late Map<String, dynamic> sp = {
  //   "maSP": "abc",
  //   "soLuong": 1,
  // };
  //
  // late List<Map<String, dynamic>> list = {sp};

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
              Expanded(
                child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("Table").snapshots(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      maBan = "Bàn ${snapShot.data!.docs.length+1}";

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
                            String id = docSnap.id;
                            String status = docSnap['trangThai'];

                            if (docSnap["HDT"] != null) {
                              colTable
                                  .doc(id)
                                  .update({"trangThai": "Chưa Thanh Toán"});
                            } else {
                              colTable.doc(id).update({"trangThai": "Trống"});
                            }
                            String trangThai = docSnap["trangThai"];
                            return GestureDetector(
                                onLongPress: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: const Text('Bạn muốn xóa bàn này'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        print(status);
                                        if(id == "Bàn ${snapShot.data!.docs.length}" && status == 'Trống' ){
                                          FirebaseFirestore.instance.collection("Table")
                                              .doc(id)
                                              .delete()
                                              .then((value) => {
                                                Get.snackbar('Thành công', 'Xóa thành công')
                                          }
                                          );
                                        }else{
                                          Get.snackbar('Thất bại', 'Bạn chỉ có thể xóa bàn cuối cùng và trạng thái trống');
                                        }
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
                                                numTable: "Bàn ${index + 1}",
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
                      return const Text("Không có bàn nào");
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
    child: Text("Hủy",
        style: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.red)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Thêm",
        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400)),
    onPressed: () {
      colTable.doc(maBan).set({
        "maBan": maBan,
        "trangThai": "Trống",
        "HDT": null,
      });
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "THÔNG BÁO",
      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700),
    ),
    content: Text(
      "Bạn chắc chắn muốn thêm bàn?",
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

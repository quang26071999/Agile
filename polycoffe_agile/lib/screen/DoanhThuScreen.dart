import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DoanhThuScreen extends StatefulWidget {
  DoanhThuScreen({super.key});

  @override
  State<DoanhThuScreen> createState() => _DoanhThuScreenState();
}

class _DoanhThuScreenState extends State<DoanhThuScreen> {
  // List listSP = [];
  //
  // List maHoaDon = ["01", "02"];
  //
  // List ngay = ["18-12-2022", "28-01-2023"];
  //
  // List nguoiNhanTien = ["Huy", "Hung"];
  //
  // List ban = ["1", "2"];
  //
  // List tenMon = ["bạc xỉu", "nước lọc"];
  //
  // List tongTien = ["80000", "45000"];
  final dateFormatter = DateFormat("dd/MM/yyyy");
  final TextEditingController tuNgay = TextEditingController();

  final TextEditingController denNgay = TextEditingController();

  var list = [];

  DateTime parseDate(String date) {
    return dateFormatter.parse(date);
  }

  int sum = 0;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 28, 252, 10),
              child: Text(
                "Từ ngày",
                style: GoogleFonts.inter(
                    fontSize: 24,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: TextField(
                onTap: ()=>{
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2020),
                    onConfirm: (date) {
                    setState(() {
                      tuNgay.text = '${date.day.toString()}/${date.month.toString()}/${date.year.toString()}';
                    });
                },
                    currentTime: DateTime.now(),
                    locale: LocaleType.vi),
                },
                controller: tuNgay,
                style: const TextStyle(fontSize: 24, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "dd/MM/yyyy",
                    filled: true,
                    fillColor: const Color(0xffffffff),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 28, 235, 10),
              child: Text(
                "Đến ngày",
                style: GoogleFonts.inter(
                    fontSize: 24,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 36),
              child: TextField(
                onTap: (()=>{
                  DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2020),
                    onConfirm: (date){
                    setState(() {
                      denNgay.text = '${date.day.toString()}/${date.month.toString()}/${date.year.toString()}';
                    });
                    },
                    locale: LocaleType.vi,
                    currentTime: DateTime.now(),
                  ),
                }),
                controller: denNgay,
                style: const TextStyle(fontSize: 24, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "dd/MM/yyyy",
                    filled: true,
                    fillColor: const Color(0xffffffff),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(88, 0, 88, 34),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () async {
                    sum =0;
                    print("hihi");
                    var ref = FirebaseFirestore.instance.collection("Bill");
                    var listBill = [];
                    int sumx = 0;
                    await ref.get().then((QuerySnapshot query) {
                          query.docs.forEach((element) {
                            if (parseDate(element['ngay'])
                                        .compareTo(parseDate(tuNgay.text)) >=
                                    0 &&
                                parseDate(element['ngay'])
                                        .compareTo(parseDate(denNgay.text)) <=
                                    0) {
                              listBill.add(element);
                              //sumx += int.parse(element['tongTien']);
                              print(element['tongTien']);

                              // List.from(element['dsSanPham']).forEach((element2) {
                              //   sumx+= int.parse(element2['gia'])*int.parse(element2['soLuong']);
                              // });
                              setState(() {
                                sum =  sum + int.parse(element['tongTien'].toString());
                                list = listBill;
                              });
                            }
                          });
                        });
                    // for (var element in listBill) {
                    //   sumx+= int.parse(element['tongtien']);
                    // }
                    //print(sumx);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.brown[900],
                  ),
                  child: Text(
                    "Kết quả",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 0, 23, 22),
              child: Text("Tổng doanh thu là $sum VND",
                  style: GoogleFonts.inter(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700)),
            ),
            Expanded(
                child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              var documentSnapshot = list[index] ;

                              return SingleChildScrollView(
                                child: GestureDetector(
                                  // width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    color: const Color(0xffffffff),
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 0, 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Text(
                                                  documentSnapshot[
                                                  "maBan"].toString()
                                                  // + ban[index],
                                                  ,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontStyle:
                                                      FontStyle.italic),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child: Text(
                                                      documentSnapshot[
                                                          "nhanVien"].toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 0, 18, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child: Text(
                                                        documentSnapshot[
                                                            "ngay"],
                                                    style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.italic)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child: Text(
                                                  "Tổng tiền: " +
                                                      documentSnapshot[
                                                              "tongTien"]
                                                          .toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        insetPadding: EdgeInsets.zero,
                                        title: const Text(
                                          'Chi tiết hoá đơn',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children:
                                              [
                                                ...List.generate(List.from(documentSnapshot["dsSanPham"]).length, (index) => Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            documentSnapshot["dsSanPham"][index]["tenSP"].toString(),
                                                            style: GoogleFonts.inter(
                                                                fontSize: 14,
                                                                fontStyle:
                                                                FontStyle
                                                                    .italic),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(right: 20),
                                                            child: Text(
                                                              documentSnapshot["dsSanPham"][index]["gia"].toString(),
                                                              style: GoogleFonts.inter(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      'x${documentSnapshot["dsSanPham"][index]["soLuong"]}',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 14,
                                                          fontStyle:
                                                          FontStyle
                                                              .italic),
                                                    ),
                                                  ],
                                                )),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 20),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "Tổng tiền: ",
                                                        style: GoogleFonts.inter(
                                                            fontSize: 14,
                                                            fontStyle:
                                                            FontStyle
                                                                .italic),
                                                      ),
                                                      Text(
                                                        documentSnapshot["tongTien"].toString(),
                                                        style: GoogleFonts.inter(
                                                            fontSize: 14,
                                                            fontStyle:
                                                            FontStyle
                                                                .italic),
                                                      ),
                                                    ],),
                                                )
                                              ]
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Ẩn', //title
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            })),

          ],
        ),
      ),
    ));
  }
}

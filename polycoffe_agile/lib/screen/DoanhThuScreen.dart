import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DoanhThuScreen extends StatefulWidget {
   DoanhThuScreen({super.key});

  @override
  State<DoanhThuScreen> createState() => _DoanhThuScreenState();
}

class _DoanhThuScreenState extends State<DoanhThuScreen> {
  List maHoaDon=["01","02"];

  List ngay=["18-12-2022","28-01-2023"];

  List nguoiNhanTien=["Huy","Hung"];

  List ban=["1","2"];

  List tenMon=["bạc xỉu","nước lọc"];

  List tongTien=["80000","45000"];

  final TextEditingController tuNgay = TextEditingController();

   final TextEditingController denNgay = TextEditingController();

   final dateFormatter = DateFormat("dd-MM-yyyy");

   DateTime parseDate(String date){
     return  dateFormatter.parse(date);
   }

   var sum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doanh Thu'),
      ),
      body: Container(
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
                child: Text("Từ ngày",
                  style: GoogleFonts.inter(fontSize: 24,color: Colors.black,fontStyle: FontStyle.italic,fontWeight:
                  FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0,32,0),

                child: TextField(
                  controller: tuNgay,
                  style: const TextStyle(fontSize: 24,color: Colors.black),
                  decoration: InputDecoration(
                      labelText: "dd/MM/yyyy",
                      filled: true,
                      fillColor: const Color(0xffffffff),
                      border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blueAccent,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 235, 10),
                child: Text("Đến ngày",
                  style: GoogleFonts.inter(fontSize: 24,color: Colors.black,fontStyle: FontStyle.italic,fontWeight:
                  FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32,36),
                child: TextField(
                  controller: denNgay,
                  style: const TextStyle(fontSize: 24,color: Colors.black),
                  decoration: InputDecoration(
                      labelText: "dd/MM/yyyy",
                      filled: true,
                      fillColor: const Color(0xffffffff),
                      border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blueAccent,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(88, 0, 88, 34),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: (){
                      print("hihi");
                        var ref = FirebaseFirestore.instance.collection("Bill");
                        var listBill = [];
                        var sumx = 0 ;
                        ref.get().then((QuerySnapshot query) => {
                            query.docs.forEach((element) {
                                if(parseDate(element['ngay']).compareTo(parseDate(tuNgay.text))>=0  && parseDate(element['ngay']).compareTo(parseDate(denNgay.text))<=0   ){
                                  listBill.add(element);
                                  sumx+= int.parse(element['tongtien']);
                                  // List.from(element['dsSanPham']).forEach((element2) {
                                  //   sumx+= int.parse(element2['gia'])*int.parse(element2['soLuong']);
                                  // });
                                }
                                setState(() {
                                  sum = sumx;
                                });

                            })

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
                      style: GoogleFonts.inter(color: Colors.white,fontSize: 30,fontWeight:
                      FontWeight.w700),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 0, 23, 22),
                child: Text("Tổng doanh thu là $sum VND",
                    style: GoogleFonts.inter(fontSize: 22,fontStyle: FontStyle.italic,fontWeight:
                    FontWeight.w700 )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Card(
                            color: const Color(0xffffffff),
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text("Mã hoá đơn:"+
                                          maHoaDon[index],
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text("Người nhận tiền:"+
                                            nguoiNhanTien[index],
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text("Tên món:"+
                                            tenMon[index],
                                          style:  GoogleFonts.inter(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text("Ngày:"+ngay[index],
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic)),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text("Bàn:"+
                                          ban[index],
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),

                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text("Tổng tiền:"+
                                          tongTien[index],
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: SizedBox(
                                    height: 18,

                                    child: ElevatedButton(
                                      onPressed: (){},
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.brown[900],
                                      ),
                                      child: Text(
                                        "chi tiết",
                                        style: GoogleFonts.inter(color: Colors.white,fontSize: 13,fontWeight:
                                        FontWeight.w700),
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
              )
            ],

          ),

      ),
    );
  }
}
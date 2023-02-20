import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:polycoffe_agile/screen/AddProductToTableScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

List products = ["Cà Phê Phin", "Cà Phê Đen", "Bạc Xỉu"];
List quantity = [2, 5, 1];
late List list;
var colBill =
    FirebaseFirestore.instance.collection("Bill").doc();
final CollectionReference colTable =
    FirebaseFirestore.instance.collection("Table");

class DrinksScreen2 extends StatefulWidget {
  const DrinksScreen2({super.key, required this.maLoai, required this.idBan});

  final String idBan;
  final int maLoai;

  @override
  State<DrinksScreen2> createState() => _DrinksScreen2State();
}

class _DrinksScreen2State extends State<DrinksScreen2> {
  final db = FirebaseFirestore.instance.collection("Products");
  String searchNameProduct = "";

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
                  onChanged: (value) {
                    setState(() {
                      searchNameProduct = value;
                    });
                  },
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Products")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState ==
                                ConnectionState.waiting &&
                            snapshot.hasData != true)
                        ? Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 130),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.docs
                                  .where((element) =>
                                      element["maloai"] == widget.maLoai)
                                  .where((element) => element["tensp"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                          searchNameProduct.toLowerCase()))
                                  .length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot documentSnapshot = snapshot
                                    .data?.docs
                                    .where((element) =>
                                        element["maloai"] == widget.maLoai)
                                    .where((element) => element["tensp"]
                                        .toString()
                                        .toLowerCase()
                                        .contains(
                                            searchNameProduct.toLowerCase()))
                                    .elementAt(
                                        index) as DocumentSnapshot<Object?>;
                                String id = documentSnapshot.id; // id
                                String photo = documentSnapshot["hinhanh"];
                                String namePrd = documentSnapshot["tensp"];
                                int pricePrd = documentSnapshot["gia"];
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddProduct(
                                                    photo: photo,
                                                    namePrd: namePrd,
                                                    pricePrd: pricePrd,
                                                    idPrd: id,
                                                    idBan: widget.idBan,
                                                  )));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Card(
                                        // margin: EdgeInsets.only(bottom: 20, top: 20),
                                        color: const Color(0xffDECDB9),
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20,
                                                  bottom: 20,
                                                  left: 24),
                                              child: Image.network(
                                                documentSnapshot["hinhanh"],
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10.0),
                                                        child: Text(
                                                            documentSnapshot[
                                                                "tensp"],
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: GoogleFonts.inter(
                                                                color: const Color(
                                                                    0xff000000),
                                                                fontSize: 16,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      Text(
                                                          NumberFormat.simpleCurrency(
                                                                  locale:
                                                                      "vi_VN")
                                                              .format(int.parse(
                                                                  documentSnapshot[
                                                                          "gia"]
                                                                      .toString())),
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: GoogleFonts.inter(
                                                              color: const Color(
                                                                  0xff000000),
                                                              fontSize: 16,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ));
                  }
                  // return const Text("Không có sản phẩm");

                  ,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff492F2C),
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          _showModalBottomSheet(context, idBan: widget.idBan);
        },
      ),
    );
  }
}

void _showModalBottomSheet(BuildContext context, {required idBan}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => Container(
          height: 400,
          decoration: const BoxDecoration(
              color: Color(0xffDECDB9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hóa Đơn Tạm",
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 30, bottom: 10, left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Món đã chọn:",
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Table")
                          .doc(idBan)
                          .snapshots(),
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          DocumentSnapshot docSnap =
                              snapShot.data as DocumentSnapshot<Object>;
                          if (docSnap["HDT"] == null) {
                            return Expanded(
                                child: Center(
                              child: Text(
                                "Chưa có sản phẩm nào",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ));
                          } else {
                            list = docSnap["HDT"];
                            return Expanded(
                                child: Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: list.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Map<String, dynamic> map = list[index];
                                    return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              map["tenSP".toString()],
                                              style: GoogleFonts.inter(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              ":",
                                              style: GoogleFonts.inter(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(
                                                map["soLuong"].toString(),
                                                style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ));
                                  }),
                            ));
                          }
                        }
                        return const Text("không có dữ liệu");
                      }),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: ElevatedButton(
                              onPressed: () {
                                colTable
                                    .doc(idBan)
                                    .get()
                                    .then((DocumentSnapshot snapshot) {
                                  final snapShot =
                                      snapshot.data() as Map<String, dynamic>;
                                  if (snapShot["HDT"] == null) {
                                    showAlert2(context);
                                  } else {
                                    showAlert(context,
                                        idBan: idBan, list: list);
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff492F2C),
                              ),
                              child: const Text("Thanh Toán")),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: ElevatedButton(
                              onPressed: () {
                                colTable.doc(idBan).update({"HDT": null});
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text("Xóa")),
                        ),
                      ],
                    ),
                  )
                ],
              ))));
}

void showAlert(BuildContext context, {required idBan, list}) async {
  var logindata = await SharedPreferences.getInstance();
  Widget cancelButton = TextButton(
    child: Text("Hủy",
        style: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.red)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Thanh Toán",
        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400)),
    onPressed: () {
      String maHD = "HD${DateTime.now().millisecondsSinceEpoch.toString()}";
      int sum = 0;
      colTable.doc(idBan).get().then((DocumentSnapshot snapshot) {
        final snapShot = snapshot.data() as Map<String, dynamic>;
        List list = snapShot["HDT"];
        list.forEach((element) {
          sum += element["soLuong"] * element["gia"] as int;
        });
        colBill.set({
          "maHD": colBill.id,
          "maBan": idBan,
          "ngay": DateFormat("dd/MM/yyyy").format(DateTime.now()),
          "nhanVien": logindata!.getString("name"),
          "dsSanPham": list,
          "tongTien": sum,
        });
      });

      colTable.doc(idBan).update({"HDT": null});
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
      "Bạn chắc chắn muốn thanh toán?",
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

void showAlert2(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("OK",
        style: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.blueAccent)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "THÔNG BÁO",
      style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700),
    ),
    content: Text(
      "Không có sản phẩm để thanh toán!",
      style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic),
    ),
    backgroundColor: const Color(0xffDECDB9),
    actions: [
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

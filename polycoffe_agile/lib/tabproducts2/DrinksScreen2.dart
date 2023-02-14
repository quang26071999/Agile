import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:polycoffe_agile/screen/AddProductToTableScreen.dart';

List products = ["Cà Phê Phin", "Cà Phê Đen", "Bạc Xỉu"];
List quantity = [2, 5, 1];

class DrinksScreen2 extends StatefulWidget {
  const DrinksScreen2({Key? key}) : super(key: key);

  @override
  State<DrinksScreen2> createState() => _DrinksScreen2State();
}

class _DrinksScreen2State extends State<DrinksScreen2> {
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
                TextField(
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
                                padding: const EdgeInsets.only(top: 20),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddProduct()));
                                    },
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data?.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot docSnap =
                                              snapshot.data?.docs[index]
                                                  as DocumentSnapshot<Object?>;
                                          String id = docSnap.id;
                                          return Card(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20,
                                                          bottom: 20,
                                                          left: 24),
                                                  child: Image.memory(
                                                    base64.decode(
                                                        docSnap["hinhanh"]),
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
                                                                    bottom:
                                                                        10.0),
                                                            child: Text(
                                                                docSnap[
                                                                    "tensp"],
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: GoogleFonts.inter(
                                                                    color: const Color(
                                                                        0xff000000),
                                                                    fontSize:
                                                                        16,
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
                                                                      docSnap["gia"]
                                                                          .toString())),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
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
                                          );
                                        }))));
                      }
                      return const Text("Không có sản phẩm nào");
                    })
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff492F2C),
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          _showModalBottomSheet(context);
        },
      ),
    );
  }
}

void _showModalBottomSheet(BuildContext context) {
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
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: products.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 40,
                            right: 40
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${products[index]}:",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      if (quantity[index] == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Không bé hơn 0"),
                                          duration: Duration(seconds: 1),
                                        ));
                                        // Fluttertoast.showToast(
                                        //     msg: "Không bé hơn 0",
                                        //     toastLength: Toast.LENGTH_SHORT,
                                        //     gravity: ToastGravity.BOTTOM,
                                        //     backgroundColor: Colors.red,
                                        //     textColor: Colors.white,
                                        //     fontSize: 16.0);
                                      } else {
                                        // setState(() {
                                        //   _number--;
                                        // });
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      "${quantity[index]}",
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      // setState(() {
                                      //   _number++;
                                      // });
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff492F2C),
                              ),
                              child: const Text("Thanh Toán")),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: ElevatedButton(
                              onPressed: () {},
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
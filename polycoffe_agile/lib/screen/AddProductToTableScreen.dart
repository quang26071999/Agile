import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

CollectionReference colTable = FirebaseFirestore.instance.collection("Table");

class AddProduct extends StatefulWidget {
  final String photo, namePrd, idPrd, idBan;
  final int pricePrd;

  const AddProduct(
      {Key? key,
      required this.photo,
      required this.namePrd,
      required this.pricePrd,
      required this.idPrd,
      required this.idBan})
      : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

int _number = 0;

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff492F2C),
              title: Text(
                widget.namePrd,
                style: GoogleFonts.inter(fontSize: 24, color: Colors.white),
              ),
            ),
            backgroundColor: const Color(0xffDECDB9),
            body: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      width: 160,
                      height: 160,
                      child: Image.network(
                        widget.photo,
                        width: 140,
                        height: 140,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 45),
                      color: const Color(0xff492F2C),
                      width: 160,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: () {
                              if (_number == 0) {
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
                                setState(() {
                                  _number--;
                                });
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 18, right: 18),
                            child: Text(
                              "$_number",
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          IconButton(
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                _number++;
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 45),
                            child: Text(
                              widget.namePrd,
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 45),
                            child: Text(
                              NumberFormat.simpleCurrency(locale: "vi_VN")
                                  .format(
                                      int.parse(widget.pricePrd.toString())),
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      color: const Color(0xff492F2C),
                      width: 135,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff492F2C)),
                          onPressed: () {
                            if (_number != 0) {
                              var map;
                              int index;
                              var refX = colTable.doc(widget.idBan);
                              refX.get().then((value) {
                                print(value["maBan"]);
                                if(value["HDT"] != null){
                                  print(value["HDT"]);
                                  index = List.from(value['HDT']).indexWhere((element) => element['maSP'].toString() == widget.idPrd.toString());
                                  print(widget.idPrd.toString());
                                  print(index);
                                  if(index != -1){
                                    map = value['HDT'];
                                    print(map[0]);
                                    map[index]['soLuong'] = int.parse(map[index]['soLuong'].toString()) + _number;
                                    refX.update({
                                      "HDT": map
                                    });
                                  }  else{
                                    colTable.doc(widget.idBan).update({
                                      "HDT": FieldValue.arrayUnion([{
                                        "maSP": widget.idPrd,
                                        "tenSP": widget.namePrd,
                                        "soLuong": _number,
                                        "gia": widget.pricePrd,
                                      }])
                                    });
                                  }
                                } else{
                                colTable.doc(widget.idBan).update({
                                  "HDT": FieldValue.arrayUnion([{
                                  "maSP": widget.idPrd,
                                  "tenSP": widget.namePrd,
                                  "soLuong": _number,
                                  "gia": widget.pricePrd,
                                    }])
                                  });
                                }
                                _number = 0;
                              });

                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Số lượng sản phẩm không bằng 0"),
                                duration: Duration(seconds: 1),
                              ));
                            }
                          },
                          child: Text(
                            "THÊM",
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
                    )
                  ],
                ),
              ),
            )));
  }
}

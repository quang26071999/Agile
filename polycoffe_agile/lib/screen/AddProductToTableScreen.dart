import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

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
                "Cà Phê Đen",
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
                      child: Image.asset(
                        'assets/images/coffee.png',
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Không bé hơn 0"),
                                      duration: Duration(seconds: 1),));
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
                              "Cà Phê Đen",
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 45),
                            child: Text(
                              "40.000đ",
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
                          onPressed: () {},
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

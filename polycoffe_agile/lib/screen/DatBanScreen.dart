import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/screen/MenuOrderScreen.dart';

class DatBanScreen extends StatefulWidget {
  const DatBanScreen({super.key});

  @override
  State<DatBanScreen> createState() => _DatBanScreenState();
}

class _DatBanScreenState extends State<DatBanScreen> {
  List trangThai = [
    "Chưa thanh toán",
    "Trống",
    "Chưa thanh toán",
    "Trống",
    "Chưa thanh toán",
    "Trống",
  ];

  List soBan = [1, 2, 3, 4, 5, 6];

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
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    "Lọc theo",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Icon(
                    Icons.filter_alt_sharp,
                    size: 32,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () { Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MenuOrder()));},
                child: GridView.builder(
                    itemCount: trangThai.length,
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 60),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 23,
                      crossAxisSpacing: 26,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => Container(
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
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          style:
                                              GoogleFonts.inter(fontSize: 24),
                                          "Bàn ${soBan[index]}",
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: Text(
                                          trangThai[index],
                                          style: GoogleFonts.inter(
                                            color: trangThai[index] ==
                                                    "Chưa thanh toán"
                                                ? Color(0xffFF0000)
                                                : Color(0xff0000FF),
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: trangThai[index] ==
                                                  "Chưa thanh toán"
                                              ? Image.asset(
                                                  'assets/images/coffee.png',
                                                  width: 71,
                                                  height: 85,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                )
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16),
                                                  child: Image.asset(
                                                    'assets/images/tableCoffee.png',
                                                    width: 70,
                                                    height: 70,
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                  ),
                                                ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff492F2C),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

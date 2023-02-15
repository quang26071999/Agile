import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/tabproducts2/DrinksScreen2.dart';

class MenuOrder extends StatefulWidget {
  final String numTable;
  const MenuOrder({Key? key, required this.numTable}) : super(key: key);

  @override
  State<MenuOrder> createState() => _MenuOrderState();
}

class _MenuOrderState extends State<MenuOrder> {
  int maLoai = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xffD9D9D9),
                title: Text(widget.numTable,
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff000000))),
                bottom: TabBar(
                  labelPadding: const EdgeInsets.only(top: 12),
                  onTap: (selectedIndex) {
                    setState(() {
                      maLoai = selectedIndex + 1;
                    });
                  },
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Đồ uống',
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff000000)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Bánh ngọt',
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff000000)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Đồ ăn vặt',
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff000000)),
                      ),
                    ),
                  ],
                ),
              ),
              body: PageView(
                children: [
                  DrinksScreen2(maLoai: maLoai,)
                ],
              ),
            )));
  }
}

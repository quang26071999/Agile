import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/TabProducts/CakeScreen.dart';
import 'package:polycoffe_agile/TabProducts/JunkFoodScreen.dart';
import 'package:polycoffe_agile/tabproducts2/DrinksScreen2.dart';

class MenuOrder extends StatefulWidget {
  const MenuOrder({Key? key}) : super(key: key);

  @override
  State<MenuOrder> createState() => _MenuOrderState();
}

class _MenuOrderState extends State<MenuOrder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xffD9D9D9),
                title: Text("Bàn 1",
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff000000))),
                bottom: TabBar(
                  labelPadding: EdgeInsets.only(top: 12),
                  tabs: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Đồ uống',
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Bánh ngọt',
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Đồ ăn vặt',
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000)),
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [DrinksScreen2(), CakeScreen(), JunkFoodScreen()],
              ),
            )));
  }
}

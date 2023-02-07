import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JunkFoodScreen extends StatelessWidget {
  const JunkFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            child: Column(children: <Widget>[
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
            ]),
          ),
        )));
  }
}

import 'package:flutter/material.dart';

class JunkFoodScreen extends StatelessWidget {
  const JunkFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backgroundCoffee.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffFFFFFF),
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        hintText: "Tìm kiếm",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(),
                        )),
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}

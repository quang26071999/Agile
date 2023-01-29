import 'package:flutter/material.dart';
import 'package:polycoffe_agile/Model/Product.dart';

class DrinksScreen extends StatelessWidget {
  DrinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[Text("Đồ uống")],
      )),
    );
  }
}

import 'package:flutter/material.dart';

class JunkFoodScreen extends StatelessWidget {
  const JunkFoodScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
                Text("Đồ ăn vặt")
            ],
          )
      ),
    );
  }
}
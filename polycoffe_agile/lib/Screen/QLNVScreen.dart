import 'package:flutter/material.dart';

class QLNVScreen extends StatelessWidget {
  const QLNVScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QLNV'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
                Text("QLNV")
            ],
          )
      ),
    );
  }
}
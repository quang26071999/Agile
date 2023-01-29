import 'package:flutter/material.dart';

class DangNhapScreen extends StatelessWidget {
  const DangNhapScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dang nhap'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text("Dang nhap")
            ],
          )
      ),
    );
  }
}
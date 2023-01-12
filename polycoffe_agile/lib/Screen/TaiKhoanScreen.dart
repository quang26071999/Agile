import 'package:flutter/material.dart';

class TaiKhoanScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tai Khoan'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
                Text("Tai Khoan")
            ],
          )
      ),
    );
  }
}
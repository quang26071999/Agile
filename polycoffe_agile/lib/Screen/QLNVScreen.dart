import 'package:flutter/material.dart';

class QLNVScreen extends StatelessWidget {

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
import 'package:flutter/material.dart';

class DoanhThuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doanh Thu'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
                Text("Doanh Thu")
            ],
          )
      ),
    );
  }
}
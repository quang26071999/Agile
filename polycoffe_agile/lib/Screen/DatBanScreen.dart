import 'package:flutter/material.dart';

class DatBanScreen extends StatelessWidget {
  const DatBanScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dat Ban'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
                Text("Dat Ban")
            ],
          )
      ),
    );
  }
}
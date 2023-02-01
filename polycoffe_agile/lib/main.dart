import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:polycoffe_agile/Screen/DatBanScreen.dart';
import 'package:polycoffe_agile/Screen/DoanhThuScreen.dart';
import 'package:polycoffe_agile/Screen/MenuScreen.dart';
import 'package:polycoffe_agile/Screen/QLNVScreen.dart';
import 'package:polycoffe_agile/Screen/TaiKhoanScreen.dart';

import 'Screen/Login/Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: LoginPage(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'PolyCoffee';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    QLNVScreen(),
    MenuScreen(),
    DatBanScreen(),
    DoanhThuScreen(),
    TaiKhoanScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_outlined),
            label: 'QLNV',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_bar),
            label: 'Bàn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Doanh Thu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

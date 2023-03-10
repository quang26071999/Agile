import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:polycoffe_agile/Screen/DatBanScreen.dart';
import 'package:polycoffe_agile/Screen/DoanhThuScreen.dart';
import 'package:polycoffe_agile/Screen/MenuScreen.dart';
import 'package:polycoffe_agile/Screen/QLNVScreen.dart';
import 'package:polycoffe_agile/Screen/TaiKhoanScreen.dart';
import 'package:polycoffe_agile/screen/HelloScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: HelloScreen(),));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.selectIndex});

  static const String _title = 'PolyCoffee';
  final int selectIndex;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(selectIndex: selectIndex,),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.selectIndex});
  final int selectIndex;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late SharedPreferences logindata;
  late String username,role;
  int _selectedIndex = 0;

  @override
  void initState() {

    super.initState();
    initial();
    _selectedIndex = widget.selectIndex;
  }

  Future<void> initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString("username")!;
      role = logindata.getString('role')!;
    });
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    QLNVScreen(),
    MenuScreen(),
    DatBanScreen(),
    DoanhThuScreen(),
    TaiKhoanScreen(),
  ];
  final List<Widget> _widgetOptions2 = <Widget>[
    DatBanScreen(),
    TaiKhoanScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return role == 'Admin' ? Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(17)),
        child: BottomNavigationBar(
          backgroundColor: Color(0xffD9D9D9),
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
              label: 'B??n',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Doanh Thu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: 'T??i kho???n',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ),
      )
    )
    : Scaffold(
        body: Center(
          child: _widgetOptions2.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          child: BottomNavigationBar(
            backgroundColor: Color(0xffD9D9D9),
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.table_bar),
                label: 'B??n',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_pin),
                label: 'T??i kho???n',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue[800],
            onTap: _onItemTapped,
          ),
        )
    );

  }
}

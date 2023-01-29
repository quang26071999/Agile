import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polycoffe_agile/Model/Product.dart';
import 'package:polycoffe_agile/TabProducts/CakeScreen.dart';
import 'package:polycoffe_agile/TabProducts/DrinksScreen.dart';
import 'package:polycoffe_agile/TabProducts/JunkFoodScreen.dart';

const List<String> list = <String>['Đồ uống', 'Bánh ngọt', 'Đồ ăn vặt'];
// void main() {
//   MenuScreen();
// }

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  final TextEditingController _maSPTED = TextEditingController();
  final TextEditingController _tenSPTED = TextEditingController();
  final TextEditingController _giaSPTED = TextEditingController();

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  Product _product = new Product();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Đồ uống',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Bánh ngọt',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Đồ ăn vặt',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          title: const Text('Menu'),
        ),
        body: TabBarView(
          children: [DrinksScreen(), CakeScreen(), JunkFoodScreen()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              // barrierColor: Colors.blue,
              builder: (BuildContext context) => AlertDialog(
                // backgroundColor: const Color(0xff6ae792),
                title: const Text(
                  'Thêm sản phẩm',
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 72,
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: () {
                        print("abc");
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: TextFormField(
                        controller: _maSPTED,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nhập mã sản phẩm',
                        ),
                        onChanged: (value) => {
                        _product.maSP = value
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: TextFormField(
                        controller: _tenSPTED,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nhập tên sản phẩm',
                        ),
                        onChanged: (value) => {
                          _product.tenSP = value
                        },
                      ),
                    ),
                    TextFormField(
                      controller: _giaSPTED,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nhập giá sản phẩm',
                      ),
                      onChanged: (value) => {
                        _product.gia = value as int
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  DocumentReference documentReference = FirebaseFirestore.instance.collection("Products").doc(id);
                                  Map<String, dynamic> product = {
                                    "masp": _maSPTED.text,
                                    "tensp": _tenSPTED.text,
                                    "hinhanh": '',
                                    "gia": _giaSPTED.text,
                                    "maloai": 1
                                  };
                                  documentReference.set(product).whenComplete(() => {
                                    debugPrint("Them thanh cong"),
                                    _maSPTED.text = "",
                                    _tenSPTED.text = "",
                                    _giaSPTED.text = "",
                                    id = DateTime.now().millisecondsSinceEpoch.toString(),
                                    Navigator.pop(context)
                                  });
                                },
                                child: const Text('THÊM')),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('HUỶ'))
                        ],
                      )),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

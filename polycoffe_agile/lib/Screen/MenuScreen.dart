import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polycoffe_agile/TabProducts/CakeScreen.dart';
import 'package:polycoffe_agile/TabProducts/DrinksScreen.dart';
import 'package:polycoffe_agile/TabProducts/JunkFoodScreen.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  // Product _product = new Product();
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
          backgroundColor: const Color(0xff492F2C),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: const Color(0xffDECDB9),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _imageFile == null
                              ? const SizedBox(
                              width: 100,
                              height: 100,
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/imageDefault.png')))
                              : Image.file(
                            _imageFile!,
                            width: 100,
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 66.0),
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(Icons.add_circle),
                              onPressed: () async {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 130,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(
                                                Icons.photo_camera,
                                              ),
                                              title: const Text(
                                                'Camera',
                                                style: TextStyle(),
                                              ),
                                              onTap: () async {
                                                final XFile? image =
                                                await _imagePicker
                                                    .pickImage(
                                                    source: ImageSource
                                                        .camera);
                                                setState(() {
                                                  _imageFile =
                                                      File(image!.path);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.camera,
                                              ),
                                              title: const Text(
                                                'Bộ sưu tập',
                                                style: TextStyle(),
                                              ),
                                              onTap: () async {
                                                final XFile? image =
                                                await _imagePicker
                                                    .pickImage(
                                                    source: ImageSource
                                                        .gallery);
                                                setState(() {
                                                  _imageFile =
                                                      File(image!.path);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextField(
                              controller: _maSPTED,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Nhập mã sản phẩm',
                                  isDense: true),
                              onChanged: (value) => {
                                // _product.maSP = value
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextField(
                              controller: _tenSPTED,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Nhập tên sản phẩm',
                                  isDense: true),
                              onChanged: (value) => {
                                // _product.tenSP = value
                              },
                            ),
                          ),
                          TextField(
                            controller: _giaSPTED,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Nhập giá sản phẩm',
                                isDense: true),
                            onChanged: (value) => {},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 50.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('LƯU'),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.brown),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('HUỶ'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}


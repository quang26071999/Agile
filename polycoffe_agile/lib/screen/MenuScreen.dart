import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polycoffe_agile/TabProducts/CakeScreen.dart';
import 'package:polycoffe_agile/TabProducts/DrinksScreen.dart';
import 'package:polycoffe_agile/TabProducts/JunkFoodScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polycoffe_agile/models/product.dart';

const List<String> list = <String>['Đồ uống', 'Bánh ngọt', 'Đồ ăn vặt'];

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<StatefulWidget> createState() => _Menu();
}

class _Menu extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: GestureDetector(
          onTap: () =>  FocusManager.instance.primaryFocus?.unfocus(),
          child: MenuStatefulWidget(),
        ),
      ),
    );
  }
}

class MenuStatefulWidget extends StatefulWidget {
  const MenuStatefulWidget({super.key});

  @override
  State<MenuStatefulWidget> createState() => _MenuStatefulWidget();
}

class _MenuStatefulWidget extends State<MenuStatefulWidget> {
  final TextEditingController _maSPTED = TextEditingController();
  final TextEditingController _tenSPTED = TextEditingController();
  final TextEditingController _giaSPTED = TextEditingController();

  String id = DateTime.now().millisecondsSinceEpoch.toString();
  File? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // borderRadius: BorderRadius.all(
        //   Radius.circular(50),
        // ),
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        resizeToAvoidBottomInset: false,
        appBar: const TabBar(
          labelPadding: EdgeInsets.only(top: 12),
          tabs: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Đồ uống',
                style: TextStyle(fontSize: 20, color: Color(0xff000000)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Bánh ngọt',
                style: TextStyle(fontSize: 20, color: Color(0xff000000)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Đồ ăn vặt',
                style: TextStyle(fontSize: 20, color: Color(0xff000000)),
              ),
            ),
          ],

          // indicator: ShapeDecoration(
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          //     color: Colors.amber
          // ),
        ),
        body: TabBarView(
          children: [DrinksScreen(), CakeScreen(), JunkFoodScreen()],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff492F2C),
          onPressed: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return FractionallySizedBox(
                    heightFactor: 0.65,
                    child: Container(
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
                                              'assets/images/imageDefaut.png')))
                                  : Image.file(
                                      _imageFile!,
                                      width: 100,
                                      height: 100,
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(left: 120.0),
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
                                                        await _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 10);
                                                    setState(() {
                                                      _imageFile =
                                                          File(image!.path);
                                                    });
                                                    print(_imageFile);
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
                                                        await _imagePicker.pickImage(source: ImageSource.gallery);
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
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: TextField(
                                          controller: _maSPTED,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Nhập mã sản phẩm',
                                              isDense: true),
                                          onChanged: (value) => {},
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: TextField(
                                          controller: _tenSPTED,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Nhập tên sản phẩm',
                                              isDense: true),
                                          onChanged: (value) => {},
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
                                    ],
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 50.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.brown),
                                        onPressed: () {
                                          var documentReference =
                                              FirebaseFirestore.instance
                                                  .collection("Products");
                                                  //.doc(id);
                                          // Map<String, dynamic> product = {
                                          //   "masp": _maSPTED.text,
                                          //   "tensp": _tenSPTED.text,
                                          //   "hinhanh": base64Encode(_imageFile!.readAsBytesSync()),
                                          //   //Image.file(base64Decode(anhdaidien)) => widget ImageProvider
                                          //   // file la lay thang file
                                          //   // network la lay url
                                          //   "gia": _giaSPTED.text,
                                          //   "maloai": 1
                                          // };
                                          Product product = Product(_maSPTED.text, _tenSPTED.text, base64Encode(_imageFile!.readAsBytesSync()), int.parse(_giaSPTED.text.toString()), 1);
                                          documentReference
                                              .add(product.toJson())
                                              .whenComplete(() => {
                                                    setEmpty(),
                                                    Navigator.pop(context)
                                                  })
                                              .then((value) =>
                                                  debugPrint("Them thanh cong"))
                                              .catchError((error) =>
                                                  debugPrint("Them that bai ${error}"));
                                        },
                                        child: const Text('LƯU'),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.brown),
                                      onPressed: () => {
                                        setEmpty(),
                                        Navigator.pop(context)
                                      },
                                      child: const Text('HUỶ'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    ));
  }

  Future<void> setEmpty() async {
    _imageFile = null;
    _maSPTED.text = "";
    _tenSPTED.text = "";
    _giaSPTED.text = "";
    // id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

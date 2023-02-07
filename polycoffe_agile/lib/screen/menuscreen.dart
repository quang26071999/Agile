import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polycoffe_agile/models/product.dart';
import 'package:google_fonts/google_fonts.dart';

import '../TabProducts/CakeScreen.dart';
import '../TabProducts/DrinksScreen.dart';
import '../TabProducts/JunkFoodScreen.dart';

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
      // resizeToAvoidBottomInset: false,
      body: Center(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return SafeArea(
        // borderRadius: BorderRadius.all(
        //   Radius.circular(50),
        // ),
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: const Color(0xffD9D9D9),
          resizeToAvoidBottomInset: false,
          appBar: TabBar(
            labelPadding: EdgeInsets.only(top: 12),
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Đồ uống',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Bánh ngọt',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Đồ ăn vặt',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
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
          floatingActionButton: Visibility(
            visible: showFab,
            child: FloatingActionButton(
              backgroundColor: const Color(0xff492F2C),
              onPressed: () {
                showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return FractionallySizedBox(
                        heightFactor: 0.6,
                        child: Container(
                          color: const Color(0xffDECDB9),
                          child: Center(
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 46),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 70),
                                            child: _imageFile == null
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
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 14, top: 80),
                                            child: IconButton(
                                              iconSize: 30,
                                              icon:
                                                  const Icon(Icons.add_circle),
                                              onPressed: () async {
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SizedBox(
                                                      height: 130,
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            ListTile(
                                                              leading:
                                                                  const Icon(
                                                                Icons
                                                                    .photo_camera,
                                                              ),
                                                              title: const Text(
                                                                'Camera',
                                                                style:
                                                                    TextStyle(),
                                                              ),
                                                              onTap: () async {
                                                                final XFile?
                                                                    image =
                                                                    await _imagePicker.pickImage(
                                                                        source: ImageSource
                                                                            .camera,
                                                                        imageQuality:
                                                                            10);
                                                                setState(() {
                                                                  _imageFile =
                                                                      File(image!
                                                                          .path);
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            ListTile(
                                                              leading:
                                                                  const Icon(
                                                                Icons.camera,
                                                              ),
                                                              title: const Text(
                                                                'Bộ sưu tập',
                                                                style:
                                                                    TextStyle(),
                                                              ),
                                                              onTap: () async {
                                                                final XFile?
                                                                    image =
                                                                    await _imagePicker
                                                                        .pickImage(
                                                                            source:
                                                                                ImageSource.gallery);
                                                                setState(() {
                                                                  _imageFile =
                                                                      File(image!
                                                                          .path);
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
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
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 34.0),
                                            child: Container(
                                              width: 280,
                                              height: 40,
                                              child: TextField(
                                                controller: _tenSPTED,
                                                decoration: const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        'Nhập tên sản phẩm cần thêm',
                                                    isDense: true),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 280,
                                            height: 40,
                                            child: TextField(
                                              controller: _giaSPTED,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      'Nhập giá sản phẩm cần thêm',
                                                  isDense: true),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 46),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 24.0),
                                          child: Container(
                                            width: 128,
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xff492F2C)),
                                              onPressed: () {
                                                var documentReference =
                                                    FirebaseFirestore.instance
                                                        .collection("Products");
                                                Product product = Product(
                                                    id,
                                                    _tenSPTED.text,
                                                    base64Encode(_imageFile!
                                                        .readAsBytesSync()),
                                                    int.parse(_giaSPTED.text
                                                        .toString()),
                                                    1);
                                                documentReference
                                                    .add(product.toJson())
                                                    .whenComplete(() => {
                                                          setEmpty(),
                                                          Navigator.pop(context)
                                                        })
                                                    .then((value) => debugPrint(
                                                        "Thêm thành công"))
                                                    .catchError((error) =>
                                                        debugPrint(
                                                            "Thêm thất bại:  ${error}"));
                                              },
                                              child: Text('LƯU',
                                                  style: GoogleFonts.inter(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Color(0xffffffff))),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 128,
                                          height: 40,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xff492F2C)),
                                            onPressed: () => {
                                              setEmpty(),
                                              Navigator.pop(context)
                                            },
                                            child: Text('HUỶ',
                                                style: GoogleFonts.inter(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffffffff))),
                                          ),
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
          )),
    ));
  }

  Future<void> setEmpty() async {
    _imageFile = null;
    _maSPTED.text = "";
    _tenSPTED.text = "";
    _giaSPTED.text = "";
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
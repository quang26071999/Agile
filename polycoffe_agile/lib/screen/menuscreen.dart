import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polycoffe_agile/models/product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/tabsproducts/showproducts.dart';
import 'package:get/get.dart';

File? _imageFile;
final ImagePicker _imagePicker = ImagePicker();

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<StatefulWidget> createState() => _Menu();
}

class _Menu extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  int maLoai = 1;

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: const Color(0xffD9D9D9),
          appBar: TabBar(
            labelPadding: EdgeInsets.only(top: 12),
            onTap: (selectedIndex) {
              setState(() {
                maLoai = selectedIndex + 1;
              });
              // print(maLoai);
            },
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
          ),
          body: PageView(
            children: [
              ShowProducts(
                maLoai: maLoai,
              )
            ],
          ),
          floatingActionButton: showFloatingActionButton()),
    ));
  }
}

class showFloatingActionButton extends StatelessWidget {
  final TextEditingController _maSPTED = TextEditingController();
  final TextEditingController _tenSPTED = TextEditingController();
  final TextEditingController _giaSPTED = TextEditingController();

  // final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
  int maLoai = 1;

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: showFab,
      child: FloatingActionButton(
        backgroundColor: const Color(0xff492F2C),
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return FractionallySizedBox(
                  heightFactor: 0.66,
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      color: const Color(0xffDECDB9),
                      child: Center(
                        child: SingleChildScrollView(
                          reverse: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 46),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        padding: const EdgeInsets.only(
                                            left: 14, top: 80),
                                        child: IconButton(
                                          iconSize: 30,
                                          icon: const Icon(Icons.add_circle),
                                          onPressed: () async {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return chooseTypeAddImage();
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
                                        padding:
                                            const EdgeInsets.only(bottom: 34.0),
                                        child: Container(
                                          width: 280,
                                          // height: 40,
                                          child: TextFormField(
                                            controller: _tenSPTED,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText:
                                                    'Nhập tên sản phẩm cần thêm',
                                                isDense: true),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'Vui lòng nhập tên sản phẩm';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 280,
                                        // height: 40,
                                        child: TextFormField(
                                          controller: _giaSPTED,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  'Nhập giá sản phẩm cần thêm',
                                              isDense: true),
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Vui lòng nhập giá sản phẩm';
                                            }
                                            if (int.parse(text) <= 0) {
                                              return 'Vui lòng nhập giá sản phẩm > 0 đ';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 46),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 24.0),
                                      child: Container(
                                        width: 128,
                                        height: 40,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xff492F2C)),
                                          onPressed: () async {
                                            if (_imageFile == null) {
                                              Get.snackbar(
                                                "Thông báo",
                                                "Vui lòng thêm ảnh cho sản phẩm",
                                                backgroundColor:
                                                    Color(0xffDECDB9),
                                              );
                                            } else if (_formKey.currentState!
                                                    .validate() &&
                                                _imageFile != null) {
                                              final storageRef = FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(id);
                                              try {
                                                await storageRef
                                                    .putFile(_imageFile!);
                                              } on FirebaseException catch (e) {
                                                // ...
                                                print(e.message);
                                              }
                                              var documentReference = FirebaseFirestore.instance.collection("Products").doc();
                                              var url = await storageRef.getDownloadURL();
                                              Product product = Product(
                                                  documentReference.id,
                                                  _tenSPTED.text,
                                                  url,
                                                  int.parse(_giaSPTED.text
                                                      .toString()),
                                                  maLoai);
                                              documentReference
                                                  .set(product.toJson())
                                                  .whenComplete(() => {
                                                        setEmpty(),
                                                        Navigator.pop(context)
                                                      })
                                                  .then((value) => debugPrint(
                                                      "Thêm thành công"))
                                                  .catchError((error) => debugPrint(
                                                      "Thêm thất bại:  ${error}"));
                                            }
                                          },
                                          child: Text('LƯU',
                                              style: GoogleFonts.inter(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffffffff))),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 128,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff492F2C)),
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
                  ),
                );
              });
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void setEmpty()  {
    _imageFile = null;
    _maSPTED.text = "";
    _tenSPTED.text = "";
    _giaSPTED.text = "";
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

}

class chooseTypeAddImage extends StatefulWidget {
  const chooseTypeAddImage({super.key});

  @override
  State<chooseTypeAddImage> createState() => _chooseTypeAddImageState();
}

class _chooseTypeAddImageState extends State<chooseTypeAddImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.photo_camera,
              ),
              title: const Text(
                'Camera',
              ),
              onTap: () async {
                final XFile? image = await _imagePicker.pickImage(
                    source: ImageSource.camera, imageQuality: 10);
                setState(() {
                  _imageFile = File(image!.path);
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
              ),
              onTap: () async {
                final XFile? image =
                    await _imagePicker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _imageFile = File(image!.path);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product{
  late String _maSP;
  late String _tenSP;
  late String _hinhAnh;
  late int _gia;
  late int _maLoai;

  Product();

  int get maLoai => _maLoai;

  set maLoai(int value) {
    _maLoai = value;
  }

  int get gia => _gia;

  set gia(int value) {
    _gia = value;
  }

  String get hinhAnh => _hinhAnh;

  set hinhAnh(String value) {
    _hinhAnh = value;
  }

  String get tenSP => _tenSP;

  set tenSP(String value) {
    _tenSP = value;
  }

  String get maSP => _maSP;

  set maSP(String value) {
    _maSP = value;
  }

  // createStudent(){
  //   print("click Create");
  //   DocumentReference documentReference = FirebaseFirestore.instance.collection("Products").doc(_maSP);
  //   Map<String, dynamic> product = {
  //     "masp": _maSP,
  //     "tensp": _tenSP,
  //     "hinhanh": _hinhAnh,
  //     "gia": _gia,
  //     "maloai": _maLoai
  //   };
  //   documentReference.set(product).whenComplete(() => {
  //     debugPrint("Them thanh cong")
  //   });
  // }
  // // readStudent(){
  // //   print("read");
  // // }
  // updateStudent(String id){
  //   print("click update");
  //   DocumentReference documentReference = FirebaseFirestore.instance.collection("Products").doc(id);
  //   Map<String, dynamic> product = {
  //     "masp": _maSP,
  //     "tensp": _tenSP,
  //     "hinhanh": _hinhAnh,
  //     "gia": _gia,
  //     "maloai": _maLoai
  //   };
  // }
  //
  // deleteStudent(String _maSP){
  //   print("click delete");
  //   DocumentReference documentReference = FirebaseFirestore.instance.collection("Products").doc(_maSP);
  //   documentReference.delete().whenComplete(() => {
  //     debugPrint("Xoa thanh cong")
  //   });
  // }

// SanPham(this._maSP, this._tenSP, this._hinhAnh, this._gia, this._maLoai);

}
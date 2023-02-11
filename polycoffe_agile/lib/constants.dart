import 'package:flutter/material.dart';

const defaultPadding = 20.0;
const color = Color.fromRGBO(222, 205, 185, 1);
const defaultDuration = Duration(milliseconds: 400);
class GioiTinhChoice {
  String gioiTinhChoice;
  int indexGT;
  GioiTinhChoice({required this.indexGT, required this.gioiTinhChoice});
}
String default_gioiTinh = "Nam";
int default_index_gioiTinh = 1;
List<GioiTinhChoice> listGT = [
  GioiTinhChoice(indexGT: 0, gioiTinhChoice: "Nam"),
  GioiTinhChoice(indexGT: 1, gioiTinhChoice: "Nữ"),
];


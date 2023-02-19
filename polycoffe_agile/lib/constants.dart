import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

late SharedPreferences logindata ;

String avatar = logindata.getString("avatar")!;
String username = logindata.getString("username")!;
String name = logindata.getString("name")!;
String role = logindata.getString("role")!;
String sex = logindata.getString("sex")!;
String dateOfBirth = logindata.getString("dateOfBirth")!;
String address = logindata.getString("address")!;
String password = logindata.getString("password")!;






// import 'dart:html';

import 'package:flutter/material.dart';

class QLNVScreen extends StatelessWidget {
  QLNVScreen({super.key});

  List ChucVu=["Nhân viên","Nhân viên","Admin"];
  List HoTen=["Phùng Hiển","Thế Hùng","Nguyễn Quang"];
  List Username=["PH","TH","NQ"];
  List Birthday=["20-12-1998","1-1-2001","1-1-1999"];
  List Password=["1234","1234","1234"];
  List GioiTinh=["Nam","Nam","Nam"];
  List DiaChi=["Nam Định","Thanh Hóa","Hải Dương"];
  List SDT=["023024242","03462632","034734723"];

  int _chucVuValue = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   title: const Text('QLNV'),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundCoffee.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(
          minimum: EdgeInsets.fromLTRB(10,40,10,0),
          child: Column(

            children: [
              TextField(
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    hintText: "Tìm nhân viên",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(),
                    )
                ),
              ),

              ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context,int index) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding:const EdgeInsets.symmetric(vertical: 15.0),
                    child: Card(
                      color: const Color(0xffDECDB9),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(

                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 5.0),
                            width: 52.41,
                            height: 52.41,
                            child: const CircleAvatar(

                              backgroundImage: NetworkImage("https://www.w3schools.com/howto/img_avatar.png"),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Chức vụ: " + ChucVu[index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Username: " + Username[index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Password: " + Password[index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Địa chỉ: " + DiaChi[index]),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Họ và tên: " + HoTen[index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child:  Text("Ngày sinh: " + Birthday[index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child:  Text("Giới tính: " + GioiTinh[index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Số điện thoại: " + SDT[index]),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
              )


            ],
          ),
        ),

      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff492F2C),
        onPressed: (){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),
              ),
              builder: (BuildContext context){
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 750.0,
                  color: const Color(0xffDECDB9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        iconSize: 72,
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: () {

                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 80.0),
                            child: (
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: _chucVuValue,
                                      onChanged: (value){

                                      },
                                    ),
                                    const SizedBox(width: 5.0,),
                                    const Text("Admin",style: TextStyle(fontSize: 20),)
                                  ],
                                )
                            ),
                          ),
                          Row(

                            children: [
                              Radio(
                                value: 2,
                                groupValue: _chucVuValue,
                                onChanged: (value){},
                              ),
                              const SizedBox(width: 5.0,),
                              const Text("Nhân viên",style: TextStyle(fontSize: 20),)
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,21,0,13),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffffffff),
                            border: OutlineInputBorder(),
                            prefixIcon: SizedBox(
                                width: 50,
                                child: Icon(Icons.supervised_user_circle_outlined)),
                            hintText: 'Nhập username',
                          ),
                          onChanged: (value) => {
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffffffff),
                            border: OutlineInputBorder(),
                            prefixIcon: SizedBox(
                                width: 50,
                                child: Icon(Icons.lock_open)),
                            hintText: 'Nhập password',
                          ),
                          onChanged: (value) => {

                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17),
                        child: TextFormField(

                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffffffff),
                            border: OutlineInputBorder(),
                            prefixIcon: SizedBox(
                                width: 50,
                                child: Icon(Icons.supervised_user_circle_sharp)),
                            hintText: 'Nhập họ tên',
                          ),
                          onChanged: (value) => {

                          },
                        ),

                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text("Giới tính: ",style: TextStyle(fontSize: 16),),
                          Container(
                            padding: const EdgeInsets.only(right: 70.0),
                            child: (
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: _chucVuValue,
                                      onChanged: (value){

                                      },
                                    ),
                                    const SizedBox(width: 5.0,),
                                    const Text("Nam",style: TextStyle(fontSize: 16),)
                                  ],
                                )
                            ),
                          ),
                          Row(

                            children: [
                              Radio(
                                value: 2,
                                groupValue: _chucVuValue,
                                onChanged: (value){},
                              ),
                              const SizedBox(width: 5.0,),
                              const Text("Nữ",style: TextStyle(fontSize: 16),)
                            ],
                          )
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,15,0,13),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffffffff),
                            border: OutlineInputBorder(),
                            prefixIcon: SizedBox(
                                width: 50,
                                child: Icon(Icons.calendar_month_outlined)),
                            hintText: 'Nhập ngày sinh',
                          ),
                          onChanged: (value) => {
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),

                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffffffff),
                            border: OutlineInputBorder(),
                            prefixIcon: SizedBox(
                                width: 50,
                                child: Icon(Icons.map_outlined)),
                            hintText: 'Nhập địa chỉ',
                          ),
                          onChanged: (value) => {

                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,24),
                        child: TextFormField(

                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffffffff),
                            border: OutlineInputBorder(),
                            prefixIcon: SizedBox(
                                width: 50,
                                child: Icon(Icons.phone)),
                            hintText: 'Nhập số điện thoại',
                          ),
                          onChanged: (value) => {

                          },
                        ),
                      ),

                      Row(
                        children: [
                          Container(
                            width: 150,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.brown),
                                child: const Text('Lưu', style: TextStyle(fontSize: 22),),
                                onPressed: ()=>{

                                }
                            ),
                          ),
                          Container(
                            width: 200,
                            padding: const EdgeInsets.only(left: 50),

                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.brown),
                                child: const Text('Hủy', style: TextStyle(fontSize: 22),),
                                onPressed: () => Navigator.pop(context)
                            ),
                          )
                        ],
                      )

                    ],
                  ),


                );
              });
        },
        child:const Icon(Icons.add),
      ),
    );
  }
}
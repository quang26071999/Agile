import 'package:flutter/material.dart';

class DoanhThuScreen extends StatelessWidget {
   DoanhThuScreen({super.key});
  List maHoaDon=["01","02"];
  List ngay=["18-12-2022","28-01-2023"];
  List nguoiNhanTien=["Huy","Hung"];
  List ban=["1","2"];
  List tenMon=["bạc xỉu","nước lọc"];
  List tongTien=["80000","45000"];
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doanh Thu'),
      ),
      body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 250, 15),
                child: Text("Từ ngày",
                  style: TextStyle(fontSize: 20,color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40,0),
                child: TextField(
                  style: const TextStyle(fontSize: 18,color: Colors.black),
                  decoration: InputDecoration(
                      labelText: "dd/MM/yyyy",

                      border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blueAccent,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 250, 15),
                child: Text("Đến ngày",
                  style: TextStyle(fontSize: 20,color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40,0),
                child: TextField(
                  style: const TextStyle(fontSize: 18,color: Colors.black),
                  decoration: InputDecoration(
                      labelText: "dd/MM/yyyy",

                      border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blueAccent,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: null,

                    child: Text(
                      "Show",
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),

                  ),
                ),
              ),
              Text("Tổng doanh thu là 125.000 VND",
                  style: TextStyle(fontSize: 24)
              ),
              ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Card(
                          color: const Color(0xffDECDB9),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text("Mã hoá đơn:"+
                                      maHoaDon[index],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text("Người nhận tiền:"+
                                        nguoiNhanTien[index],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text("Tên món:"+
                                        tenMon[index],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(80, 0, 0, 0),
                                    child: Text("Ngày:"+ngay[index],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic)),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text("Bàn:"+
                                      ban[index],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(80, 0, 0, 0),
                                    child: Text("Tổng tiền:"+
                                      tongTien[index],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
            ],

          ),

      ),
    );
  }

}
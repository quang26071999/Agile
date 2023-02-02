import 'package:flutter/material.dart';

class DatBanScreen extends StatefulWidget {
  const DatBanScreen({super.key});

  @override
  State<DatBanScreen> createState() => _DatBanScreenState();
}

class _DatBanScreenState extends State<DatBanScreen> {
  List TrangThai = [
    "Chưa thanh toán",
    "Trống",
    "Chưa thanh toán",
    "Trống",
    "Chưa thanh toán",
    "Trống",
  ];

  List SoBan = [1, 2, 3, 4, 5, 6];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Row(
                children: const [
                  Text(
                    "Lọc theo",
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Icon(
                    Icons.filter_alt_sharp,
                    size: 32,
                  )
                ],
              ),
            ),
            GridView.builder(
                itemCount: TrangThai.length,
                padding: const EdgeInsets.only(right: 20, left: 20, top: 68),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 23,
                  crossAxisSpacing: 26,
                ),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                      width: 147,
                      height: 147,
                      child: Card(
                        color: const Color(0xffFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      style: const TextStyle(fontSize: 24),
                                      "Bàn ${SoBan[index]}",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Text(
                                      TrangThai[index],
                                      style: TextStyle(
                                        color: TrangThai[index] ==
                                                "Chưa thanh toán"
                                            ? Color(0xffFF0000)
                                            : Color(0xff0000FF),
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 21.0),
                                    child: TrangThai[index] == "Chưa thanh toán"
                                        ? Image.asset(
                                            'assets/images/coffee.png',
                                            width: 71,
                                            height: 70,
                                            alignment: Alignment.bottomCenter,
                                          )
                                        : Image.asset(
                                            'assets/images/tableCoffee.png',
                                            width: 70,
                                            height: 70,
                                            alignment: Alignment.bottomCenter,
                                          ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff492F2C),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

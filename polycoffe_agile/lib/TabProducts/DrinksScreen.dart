import 'package:flutter/material.dart';

class DrinksScreen extends StatelessWidget {
  DrinksScreen({super.key});

  List drinks = ["Cà Phê Phin", "Cà Phê Đen", "Bạc Xỉu"];
  List prices = ["50.000 VND", "35.000 VND", "40.000 VND"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        hintText: "Tìm kiếm",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(),
                        )),
                  ),
                  ListView.builder(
                      itemCount: 3,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50.0),
                                    child: Image.network(
                                      "https://kingcoffee.com.vn/wp-content/uploads/2022/11/1.jpg",
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  Column(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          drinks[index],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(prices[index],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))
                ],
              )),
        ],
      ),
    );
  }
}

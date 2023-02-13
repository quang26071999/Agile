import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/constants.dart';


class EditProfile extends StatelessWidget{
   EditProfile({super.key});

   final TextEditingController numberPhone = TextEditingController();
   final TextEditingController name = TextEditingController();
   final TextEditingController dateOfBirth = TextEditingController();
   final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
  numberPhone.text = '0329698609';
  name.text = 'Nguyễn Văn Quang';
  dateOfBirth.text = '26/07/1999';
  address.text = 'Hải Dương';
    return Scaffold(
      body: Container(
          width: 500,
          height: double.maxFinite,
          decoration: const BoxDecoration(color:  color),
          child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 28),
                        child: TextField(
                            controller: numberPhone,
                            style: GoogleFonts.inter(),
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Number Phone',
                            ),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 28),
                        child: TextField(
                          controller: name,
                          style: GoogleFonts.inter(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Name',
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 28),
                        child: TextField(
                          controller: dateOfBirth,
                          style: GoogleFonts.inter(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Date of birth',
                          ),
                        ),
                      ),
                      RadioButtons(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 28),
                        child: TextField(
                          controller: address,
                          style: GoogleFonts.inter(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Address',
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
          )),
    );
  }
}

class RadioButtons extends StatefulWidget{
  const RadioButtons({super.key});
@override
  State<StatefulWidget> createState() {
    return RadioButtonState();
  }
}
class RadioButtonState extends State<RadioButtons> {

  @override
  Widget build(BuildContext context) {
  return Row(
    children:[
      Text('Giới tính'),
      Row(
        children:
        listGT.map((data) => Container(
          height: 50,
          width: 130,
          child: RadioListTile(
              title: Text(
                  '${data.gioiTinhChoice}',
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight
                              .w400))),
              value: data.indexGT,
              groupValue:
              default_index_gioiTinh,
              onChanged: (value) {
                setState(() {
                  default_gioiTinh = data
                      .gioiTinhChoice;
                  default_index_gioiTinh =
                      data.indexGT;
                });
              }),
        ))
            .toList(),
      ),
    ]

  );
  }
}


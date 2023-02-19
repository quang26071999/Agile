import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polycoffe_agile/constants.dart';


class EditProfile extends StatelessWidget{
   EditProfile({super.key});

   final TextEditingController numberPhonetxt = TextEditingController();
   final TextEditingController nametxt = TextEditingController();
   final TextEditingController dateOfBirthtxt = TextEditingController();
   final TextEditingController addresstxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // numberPhonetxt.text = username.toString();
    // nametxt.text = name.toString() ;
    // dateOfBirthtxt.text = dateOfBirth.toString();
    // addresstxt.text = address.toString();
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
                            controller: numberPhonetxt,
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
                          controller: nametxt,
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
                          controller: dateOfBirthtxt,
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
                          controller: addresstxt,
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

class HomeEdit extends StatefulWidget{
@override
  State<StatefulWidget> createState() {
    return HomeEditState();
  }

}
class HomeEditState extends State<HomeEdit>{
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

}


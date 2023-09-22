
import 'package:flutter/material.dart';
import 'Colors_utils.dart';
import 'Scan_Screen.dart';


String pressed = "";
class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  SubjectState createState() => SubjectState();

}

class SubjectState extends State<SubjectScreen> {

  String? search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Select Subject",
          style: TextStyle(color: Colors.white,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("FFFFFF"),
              hexStringToColor("FFFFFF"),
              hexStringToColor("FFFFFF")
            ],
                begin: Alignment.topCenter, end: Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery
              .of(context)
              .size
              .height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                subject(context, "Java", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Scanner()));
                  pressed = "java";
                }),
                subject(context, "OS", () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const  Scanner()));
                  pressed = "OS";
                }),
                subject(context, "Data Structures", () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const Scanner()));
                  pressed = "Data Structures";
                }),
                subject(context, "CN", () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const  Scanner()));
                  pressed = "CN";
                }),
                subject(context, "FLAT", () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const  Scanner()));
                  pressed = "FLAT";
                }),
                subject(context, "IPR", () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const  Scanner()));
                  pressed = "IPR";
                })
              ],
            ),
          ),
        ),
      ),
    );
  }


  Container subject(BuildContext context, String sub, Function onTap) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 30,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white70;
              }
              return Colors.black;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
        child: Text(sub,
            style: const TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
    );
  }
}
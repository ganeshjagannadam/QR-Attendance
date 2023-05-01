
import 'package:attandance_qr/StudentData.dart';
import 'package:flutter/material.dart';
import 'Branch.dart';
import 'Colors_utils.dart';

String graduation = "";

class Register extends StatefulWidget{
  const Register({super.key});

  @override
  RegisterScreen createState() => RegisterScreen();
}

class RegisterScreen extends State<Register>{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Let Us know more ",
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
              .height * 0.15, 20, 0),
            child: Column(
              children:  <Widget>[
               RadioListTile(
                 title: const Text("School"),
                   value: "School",
                   groupValue: graduation, 
                   onChanged: (value) {
                 setState(() {
                   graduation = value.toString();
                 });
               }),
                RadioListTile(
                    title: const Text("B.Tech"),
                    value: "B.Tech",
                    groupValue: graduation,
                    onChanged: (value) {
                      setState(() {
                        graduation = value.toString();
                      });
                    })
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (graduation == "School") {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const StudentData()));
        }
        else if (graduation == "B.Tech") {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const Branch()));
        }
      },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward, color: Colors.white,),
      ),
    );
  }
}
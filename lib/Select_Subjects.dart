
import 'package:flutter/material.dart';
import 'Colors_utils.dart';

String subject1 = "";
String subject2 = "";
String subject3 = "";
String subject4 = "";
String subject5 = "";
String subject6 = "";
class SelectSubjects extends StatefulWidget{
  const SelectSubjects({super.key});
  
  @override
  SelectSubjectScreen createState() => SelectSubjectScreen();
}

class SelectSubjectScreen extends State<SelectSubjects>{
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;
  bool _value6 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Select Subjects",
          style:  TextStyle(color: Colors.white,
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
              child:Column(
                children:  <Widget> [
                  CheckboxListTile(
                    title: const Text('Operating System'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value1,
                    value: _value1,
                    onChanged: (bool? value1) {
                      setState(() {
                        _value1 = value1!;
                        subject1 = "Java";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Operating System'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value2,
                    value: _value2,
                    onChanged: (bool? value2) {
                      setState(() {
                        _value2 = value2!;
                        subject2 = "Operating System";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Data Structures'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value3,
                    value: _value3,
                    onChanged: (bool? value3) {
                      setState(() {
                        _value3 = value3!;
                        subject3 = "Data Structures";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('FLAT'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value4,
                    value: _value4,
                    onChanged: (bool? value4) {
                      setState(() {
                        _value4 = value4!;
                        subject4 = "FLAT";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Computer Networks'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value5,
                    value: _value5,
                    onChanged: (bool? value5) {
                      setState(() {
                        _value5 = value5!;
                        subject5 = "Computer Networks";
                      });
                    },
                  ),
                   CheckboxListTile(
                    title: const Text('DBMS'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value6,
                    value: _value6,
                    onChanged: (bool? value6) {
                      setState(() {
                        _value6 = value6!;
                        subject6 = "DBMS";
                      });
                    },
                  ),
                ],
              )
            ),
          ),
        ),
      );
  }

  Scaffold add(BuildContext context, Function onTap){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: (){
          onTap;
      },
      child: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class Ece extends StatefulWidget {
  const Ece({super.key});
  @override
 EceBranch createState() => EceBranch();
}

class EceBranch extends State<Ece> {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;
  bool _value6 = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Select Subjects",
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
                children: <Widget>[
                  CheckboxListTile(
                    title: const Text('Control Systems'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value1,
                    value: _value1,
                    onChanged: (bool? value1) {
                      setState(() {
                        _value1 = value1!;
                        subject1 = "Control Systems";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Analog Communication'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value2,
                    value: _value2,
                    onChanged: (bool? value2) {
                      setState(() {
                        _value2 = value2!;
                        subject2 = "Analog Communication";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Analog Circuits'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value3,
                    value: _value3,
                    onChanged: (bool? value3) {
                      setState(() {
                        _value3 = value3!;
                        subject3 = "Analog Circuits";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('DSP'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value4,
                    value: _value4,
                    onChanged: (bool? value4) {
                      setState(() {
                        _value4 = value4!;
                        subject4 = "DSP";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Satellite Communication'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value5,
                    value: _value5,
                    onChanged: (bool? value5) {
                      setState(() {
                        _value5 = value5!;
                        subject5 = "Satellite Communication";
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Communication Systems'),
                    secondary: const Icon(Icons.javascript_outlined),
                    autofocus: false,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    selected: _value6,
                    value: _value6,
                    onChanged: (bool? value6) {
                      setState(() {
                        _value6 = value6!;
                        subject6 = "Communication Systems";
                      });
                    },
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
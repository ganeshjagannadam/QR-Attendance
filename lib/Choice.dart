
import 'package:attandance_qr/Coordinates.dart';
import 'Reg.dart';
import 'package:flutter/material.dart';
import 'Colors_utils.dart';

class Choice extends StatefulWidget{
  const Choice({Key? key}) : super(key: key);

  @override
  ChoiceScreenState  createState() => ChoiceScreenState();
}

class ChoiceScreenState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:   const Text(
          "Select",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("87B0B5"),
              hexStringToColor("87B0B5"),
              hexStringToColor("87B0B5")
            ],
                begin: Alignment.topCenter, end: Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                StuOrProButton(context, true, (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Coordinates()));
                }),
                StuOrProButton(context, false , (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Reg()));
                })
              ],
            ),
          ),
        ),
      ),
    );

  }
}

Container StuOrProButton(BuildContext context , bool isProf, Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.pressed)){
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))), child: Text(
      isProf ? 'Professor' : 'Student',
      style: const TextStyle(
          color: Colors.black87 ,fontWeight: FontWeight.bold, fontSize: 16
      ),
    ),
    ),
  );
}

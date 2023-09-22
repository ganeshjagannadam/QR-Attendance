
import 'package:qa/Signin_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EmailOTP.dart';
import 'package:flutter/material.dart';
import 'Colors_utils.dart';
import 'SharedPreference.dart';

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
        backgroundColor: Colors.black,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          "Select",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("FFFFFF"),
              hexStringToColor("FFFFFF"),
              hexStringToColor("FFFFFF"),
            ],
                begin: Alignment.topCenter, end: Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                StuOrProButton(context, true, (){
                  isFac();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EmailScreen()));
                }),
                StuOrProButton(context, false , (){
                  isStudent();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const SignInScreen()));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  isStudent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SharedPreference.isStudent, true);
    setState(() {

    });
  }
  isFac() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SharedPreference.isProf, true);
    setState(() {

    });
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
              return Colors.white;
            }
            return const Color(0xFF7045FF);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))), child: Text(
      isProf ? 'Professor' : 'Student',
      style: const TextStyle(
          color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 16
      ),
    ),
    ),
  );
}

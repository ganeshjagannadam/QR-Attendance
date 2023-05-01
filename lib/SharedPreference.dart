
import 'dart:async';
import 'package:attandance_qr/Location.dart';
import 'package:attandance_qr/Reg.dart';
import 'package:attandance_qr/Signin_Screen.dart';
import 'package:attandance_qr/Signup_Screen.dart';
import 'package:attandance_qr/StudentData.dart';
import 'package:attandance_qr/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Branch.dart';
import 'Colors_utils.dart';
import 'FaceRecognition.dart';


class SharedPreferencesScreen extends StatefulWidget {
  const SharedPreferencesScreen({super.key});

  @override
  SharedPreference createState() =>  SharedPreference();
}
class SharedPreference extends State<SharedPreferencesScreen>{
  bool authenticated = false;
  late SharedPreferences sharedPreferences;
  static const String KEYLOGIN = "login";
  BranchScreen branchScreen = BranchScreen();
  LocationScreen locationScreen = LocationScreen();
  SignUpScreenState signUpScreenState = SignUpScreenState();
  RegState regState = RegState();
  ProfilePageScreen profilePageScreen = ProfilePageScreen();

  @override
  void initState() {
    whereToGo();
    branchScreen.getData();
    locationScreen.getData();
    regState.getData();
    profilePageScreen.getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up ",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              children: const <Widget>[
                   Center(
                      child: CircularProgressIndicator(),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void whereToGo() async{
    var sharedPref = await  SharedPreferences.getInstance();
    var isLoggedIn =  sharedPref.getBool(KEYLOGIN);
    Timer(const Duration(seconds: 2),(){
      if(isLoggedIn!=null) {
        if(isLoggedIn){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StudentData()));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
        }
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    });
  }
  auth() async {
    final authenticated = LocalAuth.authenticate();
    if(await authenticated){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SharedPreferencesScreen()));
    }
  }
}



class FaceIdPage extends StatefulWidget {
  const FaceIdPage({super.key});

  @override
  FaceIdPageScreen createState() => FaceIdPageScreen();
}


class FaceIdPageScreen extends State<FaceIdPage> {
  @override
  void initState() {
    super.initState();
    auth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Unlock Using FaceID",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: [
            hexStringToColor("FFFFFF"),
            hexStringToColor("FFFFFF"),
            hexStringToColor("FFFFFF")],
              begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery
                .of(context)
                .size
                .height * 0.1, 20, 107),
              child: Column(
                children:  <Widget>[
                  const Text(
                    "Unlock Using FingerPrint",
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  authButton(context, Icons.fingerprint, (){
                    auth();
                  })
                ],
              ),),
          ),

        )
    );
  }

  auth() async {
    final authenticated = LocalAuth.authenticate();
    if(await authenticated){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SharedPreferencesScreen()));
    }
  }
}



Container authButton(BuildContext context ,IconData iconData, Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(75, 10, 70, 20),
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
            return Colors.black;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))), child: const Text(
      "Unlock",
      style:  TextStyle(
          color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 16
      ),
    ),
    ),
  );
}
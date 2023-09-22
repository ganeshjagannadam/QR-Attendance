
import 'package:qa/Signin_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Branch.dart';
import 'Colors_utils.dart';
import 'Location.dart';
import 'Reg.dart';
import 'SharedPreference.dart';
import 'SignUp_Screen.dart';
import 'StudentData.dart';


String studentUserName = "";
String studentCourse = "";
String studentEmail = '';
String name = '';
String studentLocation = '';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageScreen createState() => ProfilePageScreen();
}


class ProfilePageScreen extends State<ProfilePage>{
  static const String keyUserName = 'StudentUserName';
  static const String keyStudentName = 'StudentName';
  static const String keyStudentLocation = 'StudentLocation';
  static const String keyStudentCourse = 'StudentCourseData';
  static const String keyEmail = 'StudentEmail';
  @override
  void initState(){
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title:  const Text(
            "Welcome Back",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
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
                children: <Widget>[
              const Center(child: Text(
                  "Continue as ",
                style: TextStyle(
                    fontStyle: FontStyle.normal, fontWeight:
                FontWeight.bold, fontSize: 25,color: Colors.black)
            ),
          ),
                  getUserData(),
                  const SizedBox(
                    height: 20,
                  ),
                  continueButton(context,Icons.arrow_forward,(){
                      setData();
                      getData();
                      isLogin();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const StudentData()));
                  }),
                ],
              ),),
          ),

        )
    );
  }


  getUserData() {
    return StreamBuilder(stream: FirebaseFirestore.instance
        .collection('Andhra Pradesh')
        .where('email', isEqualTo:em)
        .snapshots(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData) {
              DocumentSnapshot documentSnapshot = streamSnapshot.data
                  ?.docs.first as DocumentSnapshot<Object?>;
              if(documentSnapshot.exists){
                studentUserName = documentSnapshot['admission_No'].toString();
                studentCourse = documentSnapshot['Branch'].toString();
                name = documentSnapshot['name'].toString();
                studentLocation = documentSnapshot['location'].toString();
                studentEmail = documentSnapshot['email'].toString();
                return Center(child: Text(
                    studentUserName,
                    style: const TextStyle(
                        fontStyle: FontStyle.normal, fontWeight:
                    FontWeight.bold, fontSize: 25,color: Colors.black)
                ),
                );
              }
              else{
                return const Center(
                  child: Text(
                    'No Document Found',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                );
              }
          }
          return const Center(
              child: CircularProgressIndicator());
          }
    );
  }
  Future isLogin() async {
    var sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool(SharedPreference.KEYLOGIN, true);
  }
  void getData() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    course = sp.getString(keyStudentCourse).toString();
    userName = sp.getString(keyUserName).toString();
    location = sp.getString(keyStudentLocation).toString();
    email = sp.getString(keyEmail).toString();
    studentName = sp.getString(keyStudentName).toString();
  }
  void setData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(keyStudentCourse, studentCourse);
    sharedPref.setString(keyUserName, studentUserName);
    sharedPref.setString(keyStudentName, name);
    sharedPref.setString(keyStudentLocation, studentLocation);
    sharedPref.setString(keyEmail, studentEmail);
    setState(() {

    });
  }


  Container continueButton(BuildContext context ,IconData iconData, Function onTap){
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
              return const Color(0xFF7045FF);
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))), child:  const Text(
        "Continue",
        style: TextStyle(
            color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 16
        ),
      ),
      ),
    );
  }
}
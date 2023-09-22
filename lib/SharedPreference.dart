
import 'dart:async';
import 'package:qa/Choice.dart';
import 'package:qa/CollegeScreen.dart';
import 'package:qa/EmailOTP.dart';
import 'package:qa/Location.dart';
import 'package:qa/QR_Generator.dart';
import 'package:qa/Reg.dart';
import 'package:qa/Register.dart';
import 'package:qa/Signin_Screen.dart';
import 'package:qa/Signup_Screen.dart';
import 'package:qa/StudentData.dart';
import 'package:qa/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  static const String isStudent = "isStudent";
  static const String isValidProf = "isValidProf";
  static const String isProf = "isProf";
  static const String uploaadDone = 'uploadDone';
  BranchScreen branchScreen = BranchScreen();
  LocationScreen locationScreen = LocationScreen();
  SignUpScreenState signUpScreenState = SignUpScreenState();
  RegState regState = RegState();
  ProfilePageScreen profilePageScreen = ProfilePageScreen();
  FaceIdPageScreen faceIdPageScreen = FaceIdPageScreen();
  EmailScreenState emailScreenState = EmailScreenState();
  DepartmentState departmentState = DepartmentState();
  UploadFilesToFirestore uploadFilesToFirestore = UploadFilesToFirestore();

  @override
  void initState() {
    whereIamGoing();
    branchScreen.getData();
    locationScreen.getData();
    regState.getData();
    profilePageScreen.getData();
    emailScreenState.getData();
    emailScreenState.getLoginData();
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
            child: const Column(
              children: <Widget>[
              Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 6,semanticsLabel: 'Loading...')),
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
    var isSchoolStudent  = sharedPref.getBool(RegisterScreen.schoolStudent);
    Timer(const Duration(seconds: 2),(){
      if(isLoggedIn!=null) {
        if(isLoggedIn){
          if(isSchoolStudent!=null && isSchoolStudent){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GenerateQRPage()));
          }else{
            faceIdPageScreen.updateUserData();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StudentData()));
          }
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
        }
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    });
  }
  void goToProf() async {
    var sharedPref = await  SharedPreferences.getInstance();
    var isProfs = sharedPref.getBool(isValidProf);
    var isLoggedIn =  sharedPref.getBool(KEYLOGIN);
    var isUpload = sharedPref.getBool(uploaadDone);
    Timer(const Duration(seconds: 2),(){
      if(isLoggedIn!=null) {
        if(isLoggedIn){
          if(isProfs!=null && isProfs){
            emailScreenState.getLoginData();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfData()));
          }else if(isUpload!= null && isUpload){
            emailScreenState.getData();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FetchProfData()));
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CollegeScreen()));
          }
        }
        else{
          emailScreenState.navigate(const EmailScreen());
        }
      }else{
        emailScreenState.navigate(const EmailScreen());
      }
    });
  }
  whereIamGoing() async {
    var sharedPref = await  SharedPreferences.getInstance();
    var isFac = sharedPref.getBool(isProf);
    var isStuds = sharedPref.getBool(isStudent);
    if(isFac!=null && isFac){
      goToProf();
    }
    else if(isStuds!=null && isStuds){
      whereToGo();
    }else{
      goTo();
    }
  }

  goTo(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Choice()));
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
  
  final index =1;
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
            "Unlock Using FingerPrint",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
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
                  const Text(
                    "Unlock Using FingerPrint",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  authButton(context, Icons.fingerprint, () {
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
    if (await authenticated) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const SharedPreferencesScreen()));
    }
  }

  updateUserData() async {
    TimeOfDay time = TimeOfDay.now();
    if (kDebugMode) {
      print(time.hour);
    }
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('Andhra Pradesh');
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Andhra Pradesh')
        .where('admission_No', isEqualTo: userName).get();
    final documentId = querySnapshot.docs.first.id;
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Andhra Pradesh')
        .doc(documentId)
        .get();
    if (time.hour == 8) {
      Map<String,dynamic> data = userSnapshot.get('subjects');
      List<dynamic> myList = userSnapshot.get('subs');
      List<String> mylistUpdated = myList.map((item) => item.toString()).toList();
      List<String> branch = mylistUpdated;
      if (kDebugMode) {
        print(data);
      }
      for (int i = 0; i < data.length; i++) {
        String field = branch[i];
        if (data[field]) {
          collectionReference.doc(documentId).update(
              {'subjects.$field' : false,});
        }
      }
    }
  }

  Container authButton(BuildContext context, IconData iconData,
      Function onTap) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(75, 10, 70, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white;
              }
              return const Color(0xFF7045FF);
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
        child: const Text(
          "Unlock",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16
          ),
        ),
      ),
    );
  }
}
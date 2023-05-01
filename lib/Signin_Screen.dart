
import 'package:attandance_qr/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:attandance_qr/Colors_utils.dart';
import 'package:attandance_qr/Reusable_Widget.dart';
import 'SignUp_Screen.dart';

String em = "";
class SignInScreen extends StatefulWidget{
  const SignInScreen({Key? key}) : super(key: key);
  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  static  CollectionReference collectionReference = FirebaseFirestore.instance.collection("Andhra Pradesh");
   List<String> locDetails = [
    "Alluri Sitharama Raju",
    "Anakapalli",
    "Anantapuramu",
    "Annamayya",
    "Bapatla",
    "Chittoor",
    "Dr. B.R. Ambedkar Konaseema",
    "East Godavari",
    "Eluru",
    "Guntur",
    "Kakinada",
    "Krishna",
    "Kurnool",
    "Nandyal",
    "NTR",
    "Palnadu",
    "Parvathipuram Manyam",
    "Prakasam",
    "Sri Potti Sriramulu Nellore",
    "Sri Sathya Sai",
    "Srikakulam",
    "Tirupati",
    "Visakhapatnam",
    "Vizianagaram",
    "West Godavari",
    "YSR"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  logoWidget("android/assets/images/hello flutter.jpg"),
                  const SizedBox(
                    height: 100,
                  ),
                  reusableTextField(
                      "Enter Email ID", Icons.person_outline, false,
                      _emailTextController),
                  const SizedBox(
                    height: 40,
                  ),
                  reusableTextField(
                      "Enter Password", Icons.password_outlined, true,
                      _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  SigninSignUpButton(context, true, () async {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailTextController.text.trim(),
                        password: _passwordTextController.text).then((value) {
                      em = _emailTextController.text;
                      if (kDebugMode) {
                        print(em);
                      }
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>  const ProfilePage()));
                    }).onError((error, stackTrace) {
                      if (kDebugMode) {
                        print("Error ${error.toString()}");
                      }
                    });
                  }),
                  SignUpOption()
                ],
              ),),
          ),
        ));
  }
  Row SignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account ? ",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(" Sign Up",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
}
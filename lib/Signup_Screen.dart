
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:attandance_qr/Choice.dart';
import 'package:attandance_qr/Reusable_Widget.dart';
import 'package:attandance_qr/Colors_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

String email = '';
class SignUpScreen extends StatefulWidget{
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState  createState() => SignUpScreenState();
}
class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  static const String KEYNAME = 'email';

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
              .height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Padding(padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                       controller: _emailTextController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: const InputDecoration(
                         hintText: "Enter Email",
                         labelText: "Email",
                     ),
                   )
                 ],
               ),
               ),
                const SizedBox(
                  height: 20,
                ),
                Padding(padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _passwordTextController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Password"
                        ),
                      )
                    ],
                  ),
                ),
                SigninSignUpButton(context, false, () {
                        validEmail();
                        setData();
                        getData();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void getData() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    var getName = sp.getString(KEYNAME).toString();
    email = getName;
    setState(() {

    });
  }
  void setData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(KEYNAME, _emailTextController.text.toString());
    setState(() {

    });
  }
  void validEmail(){
    final bool isValid = EmailValidator.validate(_emailTextController.text.trim());
    if(isValid){
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text).then((value) {
        email = _emailTextController.text.trim();
        if (kDebugMode) {
          print("Created New Account");
        }
        if (kDebugMode) {
          print(email);
        }
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const Choice()));
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print("Error ${error.toString()}");
        }
      });
    }
    else{
      Fluttertoast.showToast(
          msg: "Enter Valid Email Address",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}



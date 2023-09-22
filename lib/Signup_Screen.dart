
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qa/Reusable_Widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Reg.dart';

String email = '';
class SignUpScreen extends StatefulWidget{
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState  createState() => SignUpScreenState();
}
class SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  static const String KEYNAME = 'email';
  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
          "Let Us Know More",
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEDEDF7),
              Color(0xFFEDEDF7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      ReusableField(
                        labelText: "Enter Your Email",
                        icon: Icons.school_outlined,
                        isPasswordType: false,
                        formKey: emailKey,
                        controller: _emailTextController,
                        animationController: _animationController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReusableField(
                        labelText: "Enter Your Password",
                        icon: Icons.password_outlined,
                        isPasswordType: true,
                        formKey: passwordKey,
                        controller: _passwordTextController,
                        animationController: _animationController,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SigninSignUpButton(
                        context,
                        false,
                            () {
                          if (emailKey.currentState!.validate() &&
                              passwordKey.currentState!.validate()) {
                            validEmail();
                          }
                        },
                        textColor: Colors.white,
                        buttonText: "Sign In",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validEmail() {
    final bool isValid =
    EmailValidator.validate(_emailTextController.text.trim());
    if (isValid) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text,
      )
          .then((value) {
        email = _emailTextController.text.trim();
        if (kDebugMode) {
          print("Created New Account");
        }
        if (kDebugMode) {
          print(email);
        }
        setData();
        getData();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Reg(),
          ),
        );
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print("Error ${error.toString()}");
        }
      });
    } else {
      Fluttertoast.showToast(
        msg: "Enter a Valid Email Address",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var getName = sp.getString(KEYNAME).toString();
    email = getName;
    setState(() {});
  }

  void setData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(KEYNAME, _emailTextController.text.toString());
    setState(() {});
  }
}


class ReusableField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool isPasswordType;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final AnimationController animationController;

  const ReusableField({
    Key? key,
    required this.labelText,
    required this.icon,
    required this.isPasswordType,
    required this.formKey,
    required this.controller,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 1),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            obscureText: isPasswordType,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              hintText: labelText,
              hintStyle: const TextStyle(color: Colors.black54),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter $labelText';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

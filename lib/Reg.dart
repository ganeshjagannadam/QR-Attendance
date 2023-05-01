
import 'package:attandance_qr/Location.dart';
import 'package:attandance_qr/SignUp_Screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Colors_utils.dart';
import 'Reusable_Widget.dart';

dynamic userName = "";
dynamic studentName = "";
class Reg extends StatefulWidget{
  const Reg({Key? key}) : super(key: key);

  @override
  RegState  createState() => RegState();
}
class RegState extends State<Reg> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _userIdController  = TextEditingController();
  final TextEditingController _email = TextEditingController();
  static const String KEYNUM = 'userName';
  static const String KEYNAME = 'studentName';
  static const String keyemail = "email";

  @override
  void initState() {
    super.initState();
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
                  height: 30,
                ),
                reusableTextField(
                    "Enter User Name", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    "Enter Roll Number", Icons.account_circle_outlined, false,
                    _userIdController),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Re-Enter Your Email ", Icons.mail, false, _email),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        userName = _userIdController.text;
        studentName = _userNameTextController.text;
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Location()));
      },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward, color: Colors.white,),
      ),
    );
  }
  void getData() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    var getName = sp.getString(KEYNAME);
    var getNum = sp.getString(KEYNUM);
    var getEmail = sp.getString(keyemail);
    userName = getNum.toString();
    studentName = getName.toString();
    email = getEmail.toString();
    setState(() {

    });
  }
  void setData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(KEYNUM,_userIdController.text.toString());
    sharedPref.setString(KEYNAME, _userNameTextController.text.toString());
    sharedPref.setString(keyemail, _email.text.toString());
    setState(() {

    });
  }
}



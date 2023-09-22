
import 'package:qa/Location.dart';
import 'package:qa/ProfilePicture.dart';
import 'package:qa/Reusable_Widget.dart';
import 'package:qa/SignUp_Screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';




dynamic userName = "";
dynamic studentName = "";
String university = "";
dynamic yearOfStudy = '';
class Reg extends StatefulWidget{
  const Reg({Key? key}) : super(key: key);

  @override
  RegState  createState() => RegState();
}
class RegState extends State<Reg> {
  final userNameKey = GlobalKey<FormState>();
  final userIdKey = GlobalKey<FormState>();
  final emailIdKey = GlobalKey<FormState>();
  final collegeKey = GlobalKey<FormState>();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _userIdController  = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _college = TextEditingController();
  static const String KEYNUM = 'userName';
  static const String KEYNAME = 'studentName';
  static const String keyemail = "email";
  static const String keyUniversity = "university";


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
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFEDEDF7),
              Color(0xFFEDEDF7),
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
                const Text("Note:  Please make sure that all"
                    "the students in your College are Entering the Same college Name",
                    style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 30,
                ),
                reusableField(text: "Enter Your Name", icon: Icons.person,
                    isPasswordType: false, formKey: userNameKey, controller: _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableField(text: "Enter Your Roll Number", icon: Icons.supervised_user_circle_rounded,
                    isPasswordType: false, formKey: userIdKey, controller: _userIdController),
                const SizedBox(
                  height: 20,
                ),
                reusableField(text: "Re-Enter Your email Address ", icon: Icons.email,
                    isPasswordType: false, formKey: emailIdKey, controller: _email),
                const SizedBox(
                  height: 20,
                ),
                reusableField(text: "Enter Your College Name", icon: Icons.school_outlined,
                    isPasswordType: false, formKey: collegeKey, controller: _college),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        userName = _userIdController.text;
        studentName = _userNameTextController.text;
        university = _college.text;
        if(userNameKey.currentState!.validate() &&
            userIdKey.currentState!.validate() && emailIdKey.currentState!.validate() && collegeKey.currentState!.validate()) {
          setData();
          getData();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Location()));
        }
      },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward, color: Colors.white)
      ),
    );
  }
  void getData() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    var getName = sp.getString(KEYNAME);
    var getNum = sp.getString(KEYNUM);
    var getEmail = sp.getString(keyemail);
    var getUnviversity = sp.getString(keyUniversity);
    userName = getNum.toString();
    studentName = getName.toString();
    email = getEmail.toString();
    university = getUnviversity.toString();
  }
  void setData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(KEYNUM,_userIdController.text.toString().trimRight());
    sharedPref.setString(KEYNAME, _userNameTextController.text.toString().trimRight());
    sharedPref.setString(keyemail, _email.text.toString().trimRight());
    sharedPref.setString(keyUniversity, _college.text.toString().trimRight());
    setState(() {

    });
  }
}


class YearOfStudy extends StatefulWidget {
  const YearOfStudy({Key? key}) : super(key: key);

  @override
  State<YearOfStudy> createState() => YearOfStudyState();
}

class YearOfStudyState extends State<YearOfStudy>
    with SingleTickerProviderStateMixin {
  List<String> year = ["1", "2", "3", "4"];
  static const String keyYear = "year";
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Select The Year Of Study",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: year.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return ListTile(
                  tileColor:
                  yearOfStudy == year[index] ? Colors.grey[200] : null,
                  onTap: () {
                    setState(() {
                      yearOfStudy = year[index];
                      if (_animationController.status !=
                          AnimationStatus.forward) {
                        _animationController.forward();
                      }
                    });
                  },
                  leading: Radio(
                    value: year[index],
                    groupValue: yearOfStudy,
                    onChanged: (value) {
                      setState(() {
                        yearOfStudy = value.toString();
                      });
                    },
                  ),
                  title: Text(
                    year[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: yearOfStudy == year[index]
                      ? ScaleTransition(
                        scale: _scaleAnimation,
                        child: const Icon(
                      Icons.school,
                      color: Colors.black,
                    ),
                  )
                      : const Icon(Icons.school, color: Colors.black),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          yearOfStudy = yearOfStudy;
          if (yearOfStudy.isNotEmpty) {
            setData();
            getData();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePictureUploader(),
                settings: const RouteSettings(name: 'Branch'),
                fullscreenDialog: true,
                maintainState: false,
              ),
            );
          } else {
            Fluttertoast.showToast(
              msg: "Select Year",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }

  void getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var getYear = sp.getString(keyYear);
    setState(() {
      yearOfStudy = getYear.toString();
    });
  }

  void setData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(keyYear, yearOfStudy);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}





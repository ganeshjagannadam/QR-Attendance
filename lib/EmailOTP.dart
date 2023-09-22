
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:qa/CollegeScreen.dart';
import 'package:qa/SharedPreference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Branch.dart';
import 'Colors_utils.dart';

String department = '';
dynamic url;
String? emails;
String college = '';
class EmailScreen extends StatefulWidget {

  const EmailScreen({super.key});

  @override
  EmailScreenState createState() => EmailScreenState();
}

class EmailScreenState extends State<EmailScreen> {
  static const String email = "Email";
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  static const String isStudent = "isStudent";
  static const String profEmail = "profEmail";
  static const String profCourse = "profCourse";
  static const String profCollege = "profCollege";

  @override
  void initState(){
    super.initState();
    getData();
  }

  Future googleLogin() async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return;
    _user= googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      emails = _user?.email;
    });
  }

  Future alreadyExists()async{
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Professor Data')
        .where('email', isEqualTo: emails).get();
        if(querySnapshot.docs.isNotEmpty){
          emails = emails;
          isUploaded();
          navigate(const FetchProfData());
        }else {
          navigate(const CollegeScreen());
        }
}
    setLoginData()async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(profEmail, emails!);
      sharedPreferences.setString(profCollege, college);
      sharedPreferences.setString(profCourse, department);
    }
    getLoginData()async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var getEmail = sharedPreferences.getString(profEmail);
      var getCollege = sharedPreferences.getString(profCollege);
      var getBranch = sharedPreferences.getString(profCourse);
      emails = getEmail.toString();
      college = getCollege.toString();
      department = getBranch.toString();
    }
  isUploaded()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SharedPreference.uploaadDone, true);
  }

  navigate(Widget screen){
    return Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) =>  screen));
  }
  saveData(){
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("Professor Data");
    Map<String, dynamic> addToData = {
      'email': emails,
      'url' : url,
      'college' :  college,
      'department' : department,
      'isValid': false
    };
    collectionReference.add(addToData);
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
          "Sign In",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFF7045FF)
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    googleLogin().then((value) {
                      if(emails != null){
                        setData();
                        getData();
                        alreadyExists();
                        const CircularProgressIndicator(color: Colors.black);
                      }
                    });
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xFF7045FF),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('android/assets/images/googleLogo.jpg'),
                            height: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(email, emails.toString());
    sharedPreferences.setBool(SharedPreference.KEYLOGIN, true);
    setState(() {

    });
  }
  void getData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    emails = sharedPreferences.getString(email);
  }

}

class FetchProfData extends StatefulWidget {
  const FetchProfData({Key? key}) : super(key: key);

  @override
  State<FetchProfData> createState() => _FetchProfDataState();
}

class _FetchProfDataState extends State<FetchProfData> {

  EmailScreenState emailScreenState = EmailScreenState();
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
            "Welcome Back",
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
                  const Center(child: Text(
                      "Continue as ",
                      style: TextStyle(
                          fontStyle: FontStyle.normal, fontWeight:
                      FontWeight.bold, fontSize: 25,color: Colors.black)
                  ),
                  ),
                  getUserData(),
                 continueButton(context, Icons.arrow_forward, (){
                   if(emails!=null){
                     if (kDebugMode) {
                       print({department,college,emails});
                     }
                     emailScreenState.setLoginData();
                     emailScreenState.getLoginData();
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfData()));
                   }
                 })
                ],
              ),),
          ),

        )
    );
  }
  isValidProf() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SharedPreference.isValidProf, true);
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
              return Colors.black;
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


  getUserData() {
    return StreamBuilder(stream: FirebaseFirestore.instance
        .collection('Professor Data')
        .where('email', isEqualTo:emails)
        .snapshots(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData) {
            DocumentSnapshot documentSnapshot = streamSnapshot.data
                ?.docs.first as DocumentSnapshot<Object?>;
            if(documentSnapshot.exists){
              bool isValid = documentSnapshot['isValid'] as bool;
              if(isValid){
                isValidProf();
                emails = documentSnapshot['email'].toString();
                department = documentSnapshot['department'].toString();
                college = documentSnapshot['college'].toString();
                return Center(child: Text(
                    emails!,
                    style: const TextStyle(
                        fontStyle: FontStyle.normal, fontWeight:
                    FontWeight.bold, fontSize: 25,color: Colors.black)
                ),
                );
              }else {
                emails = null;
                return const Center(
                  child: Text(
                    'Your Document is not verified Yet',
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
            else {
              emails = null;
              return const Center(
                child: Text(
                  'Your Document is not verified Yet',
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
          return const Center(child: CircularProgressIndicator(color: Colors.black));
        }
    );
  }
}



class Department extends StatefulWidget {
  const Department({Key? key}) : super(key: key);

  @override
  State<Department> createState() => DepartmentState();
}

class DepartmentState extends State<Department> with SingleTickerProviderStateMixin{
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Register",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: branches.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return ListTile(
                  tileColor: department == branches[index] ? Colors.grey[200] : null,
                  onTap: () {
                    setState(() {
                      department = branches[index];
                      isVal = true;
                      if (_animationController.status !=
                          AnimationStatus.forward) {
                        _animationController.forward();
                      }
                    });
                  },
                  leading: department == branches[index]
                      ? ScaleTransition(
                    scale: _scaleAnimation,
                    child: Icon(
                      getCourseIcon(branches[index]),
                      color: Colors.black,
                    ),
                  )
                      : Icon(
                    getCourseIcon(branches[index]),
                    color: Colors.black,
                  ),
                  title: Text(
                    branches[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        department = department;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UploadFiles()));
      },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward, color: Colors.white,),
      ),
    );
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  IconData getCourseIcon(String course) {
    switch (course) {
      case "CSE":
        return Icons.computer;
      case "ECE":
        return Icons.memory_outlined;
      case "EEE":
        return Icons.lightbulb;
      case "Mechanical Engineering":
        return Icons.engineering;
      case "Computer Science and Business":
        return Icons.business_center;
      case "Robotics Engineering":
        return Icons.android;
      case "Metallurgical Engineering":
        return Icons.account_tree;
      case "Telecommunication Engineering":
        return Icons.wifi;
      case "Industrial Engineering":
        return Icons.construction;
      case "Biotechnology Engineering":
        return Icons.spa;
      case "Automobile Engineering":
        return Icons.directions_car;
      case "Aerospace Engineering":
        return Icons.airplanemode_active;
      case "Chemical Engineering":
        return Icons.science;
      case "Civil Engineering":
        return Icons.architecture;
      default:
        return Icons.school;
    }
  }
}


class UploadFiles extends StatefulWidget{
  const UploadFiles({super.key});

  @override
  UploadFilesToFirestore createState() => UploadFilesToFirestore();
}

class UploadFilesToFirestore extends State<UploadFiles>{
  StreamSubscription<QuerySnapshot>? _subscription;
  EmailScreenState emailScreen = EmailScreenState();
  UploadTask? task;
  File? file;
  String? status;
  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  @override
  void initState(){
    super.initState();
    emailScreen.getData();
    isValid();
  }
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void uploadImages() async{
    if(file == null) return;
    final filename = file!.path;
    final destination = 'files/$filename';
    task = FirebaseApi.uploadFile(destination, file!);

    setState(() {

    });

    if(task ==null) return;
    final snapShot = await task!.whenComplete(() {

    });
    final urlDownload = await snapShot.ref
    .getDownloadURL();
    url = urlDownload;
    if(url!=null && emails!= null){
      emailScreen.saveData();
    }
    else{
      emailScreen.googleLogin();
      uploadImages();
    }
  }



  @override
  Widget build(BuildContext context) {
    final fileName = file!=null ? file!.path : 'No File Selected';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Files"),
        centerTitle: true,
        backgroundColor: Colors.black,
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
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Note : You can close app After Uploading Files Our Admin will verify your Documents and Authorize you",
                    style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                selectFiles(context, true, Icons.attach_file, (){
                  selectFile();
                }),
                const SizedBox(
                  height: 20,
                ),
                Text(fileName,
                    style: const TextStyle(
                        fontStyle: FontStyle.normal, fontWeight:
                    FontWeight.bold, fontSize: 15,color: Colors.black)),
                const SizedBox(
                  height: 48,
                ),
                selectFiles(context, false, Icons.cloud_upload_rounded, (){
                  uploadImages();
                }),
                const SizedBox(
                  height: 20,
                ),
                task != null ? buildUploadStatus(task!) :Container()
              ],
            ),),
        ),
      )
    );
  }

  isValid() {
    _subscription = FirebaseFirestore.instance
        .collection('Professor Data')
        .where('email', isEqualTo: emails)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final documentSnapshot = snapshot.docs.first;
        final isValid = documentSnapshot['isValid'] as bool;
        if (isValid) {
          emails = documentSnapshot['email'].toString();
          department = documentSnapshot['department'].toString();
          college = documentSnapshot['college'].toString();
          isValidProf();
          emailScreen.setLoginData();
          emailScreen.getLoginData();
          emailScreen.navigate(const FetchProfData());
        }
        setState(() {

        });
      }
    });

  }

  isUploaded()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SharedPreference.uploaadDone, true);
  }
  isValidProf() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SharedPreference.isValidProf, true);
  }


  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapShot){
      if(snapShot.hasData){
        final snap = snapShot.data!;
        final speed = (snap.bytesTransferred / pow(2, 20)).toStringAsFixed(2);
        final progress = snap.bytesTransferred/ snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);
        status = percentage;
        if(percentage == '100.00'){
          isUploaded();
        }
        return Text('$speed MB  ,$percentage%',
            style: const TextStyle(
                fontStyle: FontStyle.normal, fontWeight:
            FontWeight.bold, fontSize: 15,color: Colors.black));
      }else{
        return Container();
      }
    },
  );
}



Container selectFiles(BuildContext context ,bool isSelectFiles,IconData iconData, Function onTap){
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))), child:  Text(
      isSelectFiles?"Select Files":"Upload Files",
      style: const TextStyle(
          color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 16
      ),
    ),
    ),
  );
}


class FirebaseApi{
  static UploadTask? uploadFile(String destination, File file){
    try{
      final ref =  FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    }on FirebaseException {
      return null;
    }
  }
}



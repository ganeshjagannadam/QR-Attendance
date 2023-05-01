
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


dynamic url;
String? emails;
class EmailScreen extends StatefulWidget {

  const EmailScreen({super.key});

  @override
  EmailScreenState createState() => EmailScreenState();
}

class EmailScreenState extends State<EmailScreen> {

  static const String email = "ProfEmail";
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

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
  saveData(){
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("Professor Data");
    Map<String, dynamic> addToData = {
      'email': emails,
      'url' : url,
    };
    collectionReference.add(addToData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professor SignIn'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: const EdgeInsets.fromLTRB(75, 10, 70, 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if(states.contains(MaterialState.pressed)){
                      return Colors.white;
                    }
                    return Colors.black;
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                ),
                onPressed: () {
                  googleLogin().then((value) {
                    if(emails != null){
                      setData();
                      getData();
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>  const UploadFiles()));
                    }
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Image.asset(
                    'android/assets/images/logo.jpg',
                    fit: BoxFit.values[1],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void setData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(email, emails.toString());
    setState(() {

    });
  }
  void getData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    emails = sharedPreferences.getString(email);
    setState(() {

    });
  }

}



class UploadFiles extends StatefulWidget{
  const UploadFiles({super.key});

  @override
  UploadFilesToFirestore createState() => UploadFilesToFirestore();
}

class UploadFilesToFirestore extends State<UploadFiles>{
  EmailScreenState emailScreen = EmailScreenState();
  UploadTask? task;
  File? file;
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
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          ),
        ),
      ),
    );
  }
  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapShot){
      if(snapShot.hasData){
        final snap = snapShot.data!;
        final speed = (snap.bytesTransferred / pow(2, 20)).toStringAsFixed(2);
        final progress = snap.bytesTransferred/ snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);
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
            return Colors.black;
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
    }on FirebaseException catch(e){
      return null;
    }
  }
}
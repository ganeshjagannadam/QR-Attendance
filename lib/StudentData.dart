
import 'dart:async';
import 'package:qa/StudentProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'Colors_utils.dart';
import 'Reg.dart';
import 'ScanLocation.dart';
import 'SharedPreference.dart';
import 'details.dart';


double? studentLatitude;
double? studentLongitude;


class StudentData extends StatefulWidget {
  const StudentData({super.key});

  @override
  StudentDataState createState() => StudentDataState();
}

class StudentDataState extends State<StudentData> {
  final List<String> data = <String>["Attendance", "Add Subject"];
  final List<String> subtitle = <String>["Percentage", "View"];
  ScanLocationState scanLocationState = ScanLocationState();

  @override
  void initState() {
    super.initState();
    _determinePosition();
    coordinates();
    updateUserData();
  }

  coordinates() async {
    Position position = await _determinePosition();
    setState(() {
      studentLatitude = position.latitude;
      studentLongitude = position.longitude;
    });
  }

  updateUserData() {
    FaceIdPageScreen faceIdPageScreen = FaceIdPageScreen();
    return faceIdPageScreen.updateUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanLocationScreen()),
          );
        },
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        icon: const Icon(Icons.qr_code_scanner_rounded),
        label: const Text("Scan"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          userName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement action
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfilePage()));
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                data[index],
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                subtitle[index],
                style: const TextStyle(color: Colors.black),
              ),
              onTap: () {
                if (data[index] == "Attendance") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsPage()));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddSubject()));
                }
              },
            ),
          );
        },
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission locationPermission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Geolocator.openLocationSettings();
    return Future.error("Location Services are disabled");
  }
  locationPermission = await Geolocator.checkPermission();
  if (locationPermission == LocationPermission.denied) {
    locationPermission = await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.denied) {
      return Future.error("Location Permissions are denied");
    }
  }
  if (locationPermission == LocationPermission.deniedForever) {
    return Future.error("Location Permissions are denied forever, we cannot request the permission");
  }
  return await Geolocator.getCurrentPosition();
}



class AddSubject extends StatefulWidget {
  const AddSubject ({super.key});

  @override
  AddSubjectScreen createState() => AddSubjectScreen();
}

class AddSubjectScreen extends State<AddSubject>{
  TextEditingController subjectController = TextEditingController();
  String newSub = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        if (kDebugMode) {
          print(newSub);
        }
        if(_formKey.currentState!.validate()) {
          addSubject();
        }
      },
        icon : const Icon(Icons.add),
        label: const Text("ADD"),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title:  Text(
          userName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [
          hexStringToColor("FFFFFF"),
          hexStringToColor("FFFFFF"),
          hexStringToColor("FFFFFF")],
            begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery
              .of(context)
              .size
              .height * 0.1, 20, 107),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey, // assign the form key
                  child: Column(
                    children:  [
                      const Text("Note: Please make sure that Everyone in your class "
                          "is entering the same Subject name and avoid using space at the end",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: subjectController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text'; // return an error message if the value is empty
                          }
                          return null;// return null if the value is valid
                        },
                        onSaved: (value){
                          newSub = value!;
                        },
                      decoration: const InputDecoration(
                          labelText: 'Enter some text',
                          border: OutlineInputBorder(),
                        ),
                      )
                    ],
                  ),
                )
                ]
    )
    )
      )
    );
  }

  Future addSubject() async {
    newSub = subjectController.text.trim();
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('Andhra Pradesh');
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Andhra Pradesh')
        .where('admission_No', isEqualTo: userName)
        .get();
    final documentId = querySnapshot.docs.first.id;
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Andhra Pradesh')
        .doc(documentId)
        .get();
    newSub = newSub.trim();
    List<dynamic> myList = userSnapshot.get('subs');
    List<String> mylistUpdated = myList.map((item) => item.toString()).toList();

    if (mylistUpdated.contains(newSub)) {
      Fluttertoast.showToast(
        msg: "Subject already exists",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      List<dynamic> newSubject = [newSub];
      Map<String, dynamic> addToData = {newSub: 0};
      Map<String, dynamic> mapData = {newSub: false};

      collectionReference.doc(documentId).set(addToData,SetOptions(merge: true));
        collectionReference.doc(documentId).set({'subjects' : mapData},SetOptions(merge: true));
          collectionReference.doc(documentId).set({'subs': FieldValue.arrayUnion(newSubject)},
              SetOptions(merge: true)).whenComplete(() {
            Fluttertoast.showToast(
              msg: "Subject added successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          });
    }
  }
}

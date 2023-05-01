
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'Colors_utils.dart';
import 'Reg.dart';
import 'ScanLocation.dart';
import 'details.dart';



double? studentLatitude;
double? studentLongitude;
class StudentData extends StatefulWidget{
  const StudentData({super.key});

  @override
  Studentdata createState() =>  Studentdata();
  
}

class Studentdata extends State<StudentData>{
  final List<String> data = <String>["Attendance","Add Subject"];
  final List<String> subtitle = <String>["Percentage","View"];
  ScanLocationState scanLocationState = ScanLocationState();

  @override
  void initState(){
    super.initState();
    _determinePosition();
    coordinates();
  }
  coordinates() async {
    Position position = await _determinePosition();
    setState((){
      studentLatitude = position.latitude;
      studentLongitude = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     floatingActionButton: FloatingActionButton.extended(onPressed: () async{
       Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanLocationScreen() ));
     },
       shape:  BeveledRectangleBorder(
         borderRadius: BorderRadius.circular(5),
       ),
       icon : const Icon(Icons.qr_code_scanner_rounded),
       label: const Text("Scan"),
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
      body: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(data[index],style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: Text(subtitle[index],style: const TextStyle(color: Colors.black)),
                    onTap : (){
                          if(data[index] == "Attendance"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsPage()));
                          }
                          else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddSubject()));
                          }
                    }
                  ),
                 );
            }
        ),
    );
  }
}
Future<Position> _determinePosition() async{
  bool serviceEnabled;
  LocationPermission locationPermission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled){
    Geolocator.openLocationSettings();
    return Future.error("Location Services re disabled");
  }
  locationPermission = await Geolocator.checkPermission();
  if(locationPermission == LocationPermission.denied){
    locationPermission = await Geolocator.requestPermission();
    if(locationPermission == LocationPermission.denied){
      return Future.error("Location Permissions are denied");
    }
  }
  if(locationPermission == LocationPermission.deniedForever){
    return Future.error("Location Permissions are denied for ever, we cannot request the permission ");
  }
  return await Geolocator.getCurrentPosition();
}


class AddSubject extends StatefulWidget {
  const AddSubject ({super.key});

  @override
  AddSubjectScreen createState() => AddSubjectScreen();
}

class AddSubjectScreen extends State<AddSubject>{
  final TextEditingController _addSubjectController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        
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
                TextFormField(
                  controller: _addSubjectController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Subject Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),),
      )
    );
  }
  
  
  addSubject() async{
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('Andhra Pradesh');
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Andhra Pradesh')
        .where('admission_No', isEqualTo: userName)
        .get();
    final documentId = querySnapshot.docs.first.id;
    Map<dynamic, dynamic> addToData = {
      _addSubjectController.text : [0,false],
    };
  collectionReference.doc(documentId).set(addToData);
  }
}

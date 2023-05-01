

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:geolocator/geolocator.dart';
import 'Reg.dart';


class ScanLocationScreen extends StatefulWidget {
  const ScanLocationScreen({super.key});

  @override
  ScanLocationState createState() =>  ScanLocationState();
}

class ScanLocationState extends State<ScanLocationScreen> {

  String _qrInfo = "13.6514982,78.8051773";
  String? search;
  var len = 0;
  int count = 0;
  bool camState = false;
   double? latitude;
   double? longitude;

  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code!;
    });
  }
  coordinates() async {
    Position position = await _determinePosition();
    setState((){
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  @override
  initState() {
    super.initState();
    coordinates();
    setState(() {
      camState = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {

            if (kDebugMode) {
              print("$latitude $longitude");
            }
            if (camState == true) {
              return setState(() {
                camState = false;
              });
            }
            else {
              return setState(() {
                camState = true;
              });
            }
          },
          child: const Icon(Icons.camera_alt_outlined)),
      body: camState
          ? Center(
        child: SizedBox(
          height: 1000,
          width: 500,
          child: QRBarScannerCamera(
            onError: (context, error) =>
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
            qrCodeCallback: (code) {
              qrCallback(code);
              count++;
            },
          ),
        ),
      ) :
      SingleChildScrollView(
        child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.1, 20, 107),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                compare_qr(),
              ]
          ),
        ),
      ),
    );
  }
  compare_qr(){
    return Compare_Qr();
  }
  Compare_Qr()  {
    TimeOfDay h1 = const TimeOfDay(hour: 8, minute: 00);
    TimeOfDay h2 = const TimeOfDay(hour: 17, minute: 00);
    TimeOfDay time = TimeOfDay.now();
    coordinates();
    final split = _qrInfo.split(',');
    final CollectionReference products = FirebaseFirestore.instance.collection('Andhra Pradesh');
          try {
            return StreamBuilder(
                stream: FirebaseFirestore.instance.collection(
                    'Andhra Pradesh').where('admission_No', isEqualTo: userName)
                    .snapshots(), // Build Connection
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  String qrInfo = split[0];
                  double lat = double.parse(split[1]);
                  double lon = double.parse(split[2]);
                  DocumentSnapshot documentSnapshot = streamSnapshot.data?.docs
                      .first as DocumentSnapshot<Object?>;
                  List<dynamic> data = documentSnapshot[qrInfo];
                  if (latitude != null && longitude != null) {
                    if (lat >= latitude! - 0.500 ||
                        lat <= latitude! + 0.500 && lon >= longitude! - 0.500 ||
                        lon <= longitude! + 0.500) {
                          if (time.hour > h1.hour && time.hour < h2.hour &&
                              data[1] == false) {
                            if (count == 1) {
                              products.doc(documentSnapshot.id).update(
                                  {data[0]: FieldValue.increment(1)}).then((
                                  value) {
                                products.doc(documentSnapshot.id).update(
                                    {data[1]: true});
                                return const Center(
                                    child: Text(" QR Scan Successful",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold)));
                              }).onError((error, stackTrace) {
                                return const Center(child: Text(
                                    " Qr Data Data Not Found Or PLease Check your Location",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold)));
                              });
                              count = 0;
                            }
                          }
                          else {
                            return const Center(child: Text(
                                "Session TimeOut",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold)));
                          }
                        }
                    }
                    else {
                      return const Center(child: Text(
                          " Access Denied PLease Check your Location ",
                          style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold)));
                    }
                  return const Center(
                      child: CircularProgressIndicator());
                }
            );
          } on IndexError catch (e) {
            return Center(child: Text(
                e.stackTrace.toString(),
                style: const TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold)));
          }
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

import 'dart:core';
import 'dart:math';
import 'package:qa/Reusable_Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'Reg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanLocationScreen extends StatefulWidget {
  const ScanLocationScreen({Key? key}) : super(key: key);

  @override
  ScanLocationState createState() => ScanLocationState();
}

class ScanLocationState extends State<ScanLocationScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Security security = Security();
  String? _qrInfo;
  String? search;
  var len = 0;
  int count = 0;
  bool camState = false;
  double? latitude;
  double? longitude;

  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code;
    });
    coordinates(); // Update current location when QR code is scanned
  }

  Future<void> coordinates() async {
    Position position = await _determinePosition();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  @override
  void initState() {
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
        backgroundColor: Colors.black,
        onPressed: () async {
          if (kDebugMode) {
            print("$latitude $longitude");
          }
          setState(() {
            camState = !camState;
          });
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
      body: camState
          ? Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
        ],
      )
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).size.height * 0.1,
            20,
            107,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              compareQr(),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      qrCallback(scanData.code);
      count++;
    });
  }

  compareQr() {
    coordinates();
    TimeOfDay h1 = const TimeOfDay(hour: 8, minute: 00);
    TimeOfDay h2 = const TimeOfDay(hour: 22, minute: 00);
    TimeOfDay time = TimeOfDay.now();
    final decryptedText = security.decryptString(_qrInfo!);
    if (kDebugMode) {
      print(decryptedText);
    }
    final split = decryptedText.split(',');
    String qrInfo = split[0];
    String dateTime = split[3];
    dateTime = dateTime.trimLeft();
    DateTime qrTimestamp = DateTime.parse(dateTime);
    DateTime currentTimestamp = DateTime.now();
    Duration difference = currentTimestamp.difference(qrTimestamp);
    final double qrLatitude = double.parse(split[1]);
    final double qrLongitude = double.parse(split[2]);
    final CollectionReference products =
    FirebaseFirestore.instance.collection('Andhra Pradesh');
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Andhra Pradesh')
          .where('admission_No', isEqualTo: userName)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        try {
          if (streamSnapshot.hasData) {
            final DocumentSnapshot documentSnapshot =
            streamSnapshot.data?.docs.first as DocumentSnapshot<Object?>;
            if (documentSnapshot.exists) {
              Map<String, dynamic> data = documentSnapshot['subjects'];
              if (kDebugMode) {
                print(data);
              }
              if (latitude != null && longitude != null) {
                final double distance = calculateDistance(
                    latitude!, longitude!, qrLatitude, qrLongitude);
                if (distance <= 10) {
                  if (difference < const Duration(minutes: 10)) {
                    if (time.hour > h1.hour && time.hour < h2.hour) {
                      if (data[qrInfo]) {
                        return const Center(
                          widthFactor: 15,
                          heightFactor: 20.1,
                          child: Text(
                            "QR Scan Successful",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        );
                      } else if (data[qrInfo] == false) {
                        if (count == 1) {
                          products.doc(documentSnapshot.id).update({
                            qrInfo: FieldValue.increment(1),
                          }).then((value) {
                            products
                                .doc(documentSnapshot.id)
                                .update({'subjects.$qrInfo': true});
                          }).onError((error, stackTrace) {
                            const Center(
                              child: Text(
                                "Invalid QR",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          });
                          count = 0;
                        }
                      }
                    } else {
                      return const Center(
                        widthFactor: 15,
                        heightFactor: 20.1,
                        child: Text(
                          "Session Timed Out",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      widthFactor: 15,
                      heightFactor: 20.1,
                      child: Text(
                        "QR Expired",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    widthFactor: 15,
                    heightFactor: 20.1,
                    child: Text(
                      "Please Check Your Location.",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
              }
            }
          }
        } on RangeError {
          return const Center(
            widthFactor: 15,
            heightFactor: 20.1,
            child: Text(
              "Invalid QR",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return const Center(
            widthFactor: 15,
            heightFactor: 20.1,
            child: Text(
              "Invalid QR",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  double calculateDistance(
      double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    const int earthRadius = 6371; // in km

    double lat1 = startLatitude * (pi / 180);
    double lon1 = startLongitude * (pi / 180);
    double lat2 = endLatitude * (pi / 180);
    double lon2 = endLongitude * (pi / 180);

    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;

    double a = (sin(dlat / 2) * sin(dlat / 2)) +
        (cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2));
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
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
      return Future.error(
          "Location Permissions are denied forever, we cannot request the permission");
    }
    return await Geolocator.getCurrentPosition();
  }
}
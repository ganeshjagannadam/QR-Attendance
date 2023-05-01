
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'SubjectScreen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanState createState() =>  _ScanState();
}

class _ScanState extends State<ScanScreen> {

  String? _qrInfo;
  String? search;
  var len = 0;
  int count = 0;
  int found = 0;
  bool camState = false;

  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      camState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
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
              Compare_Qr()
            ]
        ),
      ),
     ),
    );
  }
  Compare_Qr()  {
    final CollectionReference products = FirebaseFirestore.instance.collection(
        'Test');
    return StreamBuilder(
        stream: products.snapshots(), // Build Connection
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot)  {
          int? itemCount = streamSnapshot.data?.docs.length;
          if(itemCount!= null) {
            for (int i = 0; i < itemCount; i++) {
              final DocumentSnapshot documentSnapshot = streamSnapshot.data
                  ?.docs[i] as DocumentSnapshot<Object?>;
              if (_qrInfo == documentSnapshot['admission_No']) {
                if (count == 1) {
                  products.doc(documentSnapshot.id).update(
                      {pressed: FieldValue.increment(1)});
                  count = 0;
                  found = 1;
                }
                else{
                  found = 0;
                }
                return const Text(" QR Scan Successful",
                    style: TextStyle(
                        fontSize: 25, fontStyle: FontStyle.normal));
              }
            }
            if(found == 0){
              count = 0;
              return const Text(" Data Not Found",
                  style: TextStyle(
                      fontSize: 25, fontStyle: FontStyle.normal));
            }
          }
          return const Center(
              child: CircularProgressIndicator());
        }
    );
  }
}

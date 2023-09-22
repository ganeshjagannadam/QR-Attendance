
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';


class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanState createState() =>  _ScanState();
}

class _ScanState extends State<ScanScreen> {

  String _qrInfo = '';
  String? search;
  var len = 0;
  int count = 0;
  int found = 0;
  bool camState = false;

  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code!;
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
        'Schools');
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection(
            'Schools').where('rollNumber',isEqualTo: _qrInfo).snapshots(), // Build Connection
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot)  {
          if(streamSnapshot.hasData){
              final DocumentSnapshot documentSnapshot = streamSnapshot.data
                  ?.docs.first as DocumentSnapshot<Object?>;
              if (documentSnapshot.exists){
                  if (count == 1) {
                    products.doc(documentSnapshot.id).update(
                        {_qrInfo: FieldValue.increment(1)});
                    count = 0;
                  }
                  return const Center(
                      widthFactor: 15,
                      heightFactor: 20.1,
                      child: Text(" QR Scan Successful",
                          style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold))
                  );
            }else{
                return const Center(
                    widthFactor: 15,
                    heightFactor: 20.1,
                    child: Text("No Document Found",
                        style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold))
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator());
          }
    );
  }
}


import 'package:flutter/material.dart';
import 'package:attandance_qr/Home_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  _ScannerState createState() => _ScannerState();
}
final CollectionReference subjects1 = FirebaseFirestore.instance.collection("Test");
class _ScannerState extends State<Scanner> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanScreen() ));

      },
        shape:  BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        icon : const Icon(Icons.qr_code_scanner_rounded),
        label: const Text("Scan"),
        backgroundColor: Colors.indigo,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        title: const Text("Scanner"),
      ),
      body: Column(
        children: [
       StreamBuilder(
            stream: subjects1.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: streamSnapshot.data!.docs.length, // No of Rows
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['name']),
                        subtitle:Text((documentSnapshot['java']).toString()),
                      ),
                    );
                  },
                );
              }
              else{
                return const Text("Data Not Found",
                  style: TextStyle( fontStyle: FontStyle.normal , fontSize:  30));
              }
            },
      ),
    ]
      ),
    );
  }
}

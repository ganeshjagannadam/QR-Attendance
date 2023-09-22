
import 'package:qa/Reg.dart';
import 'package:flutter/material.dart';
import 'package:qa/Home_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  ScannerState createState() => ScannerState();
}

class ScannerState extends State<Scanner> {

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
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        title: const Text("Scanner"),
      ),
      body: Column(
        children: [
       StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Schools").where("admission_No",isEqualTo: userName).
            where("school",isEqualTo:university).snapshots(),
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
                        title: Text(documentSnapshot['admission_No'].toString()),
                        subtitle:Text(documentSnapshot['attendance'].toString()),
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



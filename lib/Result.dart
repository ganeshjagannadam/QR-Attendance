
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qa/details.dart';
import 'Colors_utils.dart';
import 'Reg.dart';

int caught = 0;
class Results extends StatelessWidget{
  const Results({super.key});
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(tapped,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body:  Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("FFFFFF"),
              hexStringToColor("FFFFFF"),
              hexStringToColor("FFFFFF")
            ],
                begin: Alignment.topCenter, end: Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery
              .of(context)
              .size
              .height * 0.2, 20, 0),
            child: Column(
              children:  <Widget>[
                result()
              ],
            ),
          ),
        ),
      ),
    );
  }

  result(){
     return StreamBuilder(stream: FirebaseFirestore.instance
         .collection('Andhra Pradesh')
         .where('admission_No', isEqualTo: userName )
         .snapshots(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
        if(streamSnapshot.hasData){
            DocumentSnapshot  documentSnapshot = streamSnapshot.data?.docs.first as DocumentSnapshot<Object?>;
            if(documentSnapshot.exists){
              return Center(child: Text(
                  documentSnapshot[tapped].toString(),
                  style: const TextStyle(
                      fontStyle: FontStyle.normal, fontWeight:
                  FontWeight.bold, fontSize: 25,color: Colors.black)
              ),
              );
            }else{
              return Center(child: Text(
                  documentSnapshot[tapped].toString(),
                  style: const TextStyle(
                      fontStyle: FontStyle.normal, fontWeight:
                  FontWeight.bold, fontSize: 25,color: Colors.black)
              ),
              );
            }
       }
        return const Center(
            child: CircularProgressIndicator());
      }
    );
  }
}

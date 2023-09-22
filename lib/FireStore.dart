
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  studentScreen createState() => studentScreen();
}

class studentScreen extends State<StudentScreen>{
  final CollectionReference test = FirebaseFirestore.instance.collection('Test');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: test.snapshots(), // Build Connection
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length, // No of Rows
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['admission_No']),
                  ),
                );
              },
            );
          }
          else {
            return const Text("Data Not found ",
              style: TextStyle(fontStyle: FontStyle.normal, fontSize:  25));
          }
        },
      ),
    );
  }
}
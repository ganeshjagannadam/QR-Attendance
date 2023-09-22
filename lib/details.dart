import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Reg.dart';
import 'Result.dart';

String tapped = "";

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  DetailsPageScreen createState() => DetailsPageScreen();
}

class DetailsPageScreen extends State<DetailsPage> {
  List<String> subjects = [];
  bool _isLoaded = false;

  @override
  void initState() {
    list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          userName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: _isLoaded
          ? ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _isLoaded ? 1.0 : 0.0,
            child: Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  subjects[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: const Icon(Icons.subject),
                onTap: () {
                  tapped = subjects[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Results(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  fetch() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Andhra Pradesh")
          .where("admission_No", isEqualTo: userName)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          DocumentSnapshot documentSnapshot =
          streamSnapshot.data?.docs.first as DocumentSnapshot<Object?>;
          if (documentSnapshot.exists) {
            List<dynamic> myList = documentSnapshot['subs'];
            List<String> myListString =
            myList.map((item) => item.toString()).toList();
            subjects = myListString;
            setState(() {
              _isLoaded = true;
            });
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  list() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Andhra Pradesh')
        .where('admission_No', isEqualTo: userName)
        .get();
    final documentId = querySnapshot.docs.first.id;
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Andhra Pradesh')
        .doc(documentId)
        .get();
    List<dynamic> myList = userSnapshot.get('subs');
    List<String> myListString =
    myList.map((item) => item.toString()).toList();
    setState(() {
      subjects = myListString;
      _isLoaded = true;
    });
  }
}

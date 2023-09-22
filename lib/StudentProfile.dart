
import 'dart:io';
import 'package:qa/Reg.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';



class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  StudentProfilePageState createState() => StudentProfilePageState();
}

class StudentProfilePageState extends State<StudentProfilePage> {
  File? profilePicture;
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        profilePicture = File(pickedImage.path);
      }
    });
  }

  Future<void> _showImagePickerDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
              child: const Text('Take a picture'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Upload a picture'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Andhra Pradesh')
            .where('admission_No', isEqualTo: userName)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data!.docs;

            if (documents.isNotEmpty) {
              final data = documents[0].data();

              final name = data['name'] ?? '';
              final email = data['email'] ?? '';
              final rollNumber = data['admission_No'] ?? '';
              final college = data['college'] ?? '';
              final studyYear = data['year'] ?? '';
              final place = data['location'] ?? '';
              final branch = data['Branch'] ?? '';

              final profilePictureUrl = data['profilePic'] ?? '';

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => _showImagePickerDialog(),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: profilePicture != null
                                ? FileImage(profilePicture!)
                                : profilePictureUrl.isNotEmpty
                                ? NetworkImage(profilePictureUrl)
                                : null as ImageProvider<Object>?,
                            child: profilePicture == null &&
                                profilePictureUrl.isEmpty
                                ? const Icon(Icons.person, size: 80)
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CardWidget(
                        icon: Icons.person,
                        title: 'Name',
                        subtitle: name,
                      ),
                      CardWidget(
                        icon: Icons.email,
                        title: 'Email',
                        subtitle: email,
                      ),
                      CardWidget(
                        icon: Icons.format_list_numbered,
                        title: 'Roll Number',
                        subtitle: rollNumber,
                      ),
                      CardWidget(
                        icon: Icons.school,
                        title: 'College',
                        subtitle: college,
                      ),
                      CardWidget(
                        icon: Icons.subject,
                        title: 'Branch',
                        subtitle: branch,
                      ),
                      CardWidget(
                        icon: Icons.school_outlined,
                        title: 'Year Of Study',
                        subtitle: studyYear,
                      ),
                      CardWidget(
                        icon: Icons.location_on,
                        title: 'Location',
                        subtitle: place,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('User not found.');
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const CardWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        child: ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}

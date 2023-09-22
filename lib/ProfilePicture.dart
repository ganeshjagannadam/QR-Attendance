import 'dart:io';
import 'package:qa/Branch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';


dynamic profURL ;
class ProfilePictureUploader extends StatefulWidget {
  const ProfilePictureUploader({Key? key}) : super(key: key);

  @override
  ProfilePictureUploaderState createState() => ProfilePictureUploaderState();
}

class ProfilePictureUploaderState extends State<ProfilePictureUploader> {
  File? _image;
  double _uploadProgress = 0.0;

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? compressedImage = await _compressImage(File(pickedFile.path));
      setState(() {
        _image = compressedImage;
      });
    }
  }

  Future<void> _captureImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File? compressedImage = await _compressImage(File(pickedFile.path));
      setState(() {
        _image = compressedImage;
      });
    }
  }

  Future<File?> _compressImage(File image) async {
    final directory = await getTemporaryDirectory();
    final targetPath = '${directory.path}/compressed.jpg';
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      image.path,
      targetPath,
      quality: 70,
    );
    return compressedImage != null ? File(compressedImage.path) : null;
  }

  Future<void> _uploadImageToFirebase(BuildContext context) async {
    if (_image != null) {
      final firebaseStorageRef = FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.png');
      final uploadTask = firebaseStorageRef.putFile(_image!);
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      }, onError: (Object e) {
        if (kDebugMode) {
          print('Error uploading image: $e');
        }
      });
      await uploadTask.whenComplete(() {
        if (kDebugMode) {
          print('Image uploaded to Firebase');
        }
        // Perform any additional actions here after the upload is completed
        final downloadUrl = firebaseStorageRef.getDownloadURL();
        profURL = downloadUrl;

        Navigator.push(context, MaterialPageRoute(builder: (context) => const Branch()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded to Firebase')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          "Profile Picture",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null ? const Icon(Icons.person, size: 80) : null,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple], // Button gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ElevatedButton(
                onPressed: _getImageFromGallery,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text('Upload', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange], // Button gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ElevatedButton(
                onPressed: _captureImageFromCamera,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text('Take Photo', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _image != null
                ? Column(
              children: [
                Text('Upload Progress: ${(100 * _uploadProgress).toStringAsFixed(1)}%'),
                LinearProgressIndicator(value: _uploadProgress),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.green, Colors.teal], // Button gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () => _uploadImageToFirebase(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Text('Next', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

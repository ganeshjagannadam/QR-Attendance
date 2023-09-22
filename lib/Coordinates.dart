
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'Reusable_Widget.dart';

class Coordinates extends StatefulWidget {
  const Coordinates({Key? key}) : super(key: key);

  @override
  CoordinatesState createState() => CoordinatesState();
}

class CoordinatesState extends State<Coordinates>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  TextEditingController textController = TextEditingController();
  String qrData = "";
  bool isQRGenerating = false;
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _buttonAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "GPS Coordinates",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.blue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    RepaintBoundary(
                      key: qrKey,
                      child: QrImageView(
                        data: qrData,
                        version: QrVersions.auto,
                        size: 300,
                        backgroundColor: Colors.white,
                        eyeStyle: const QrEyeStyle(
                          color: Colors.black,
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    if (isQRGenerating)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Subject Name',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _buttonAnimationController.forward().then((_) {
                      _buttonAnimationController.reverse();
                      _generateQR();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ), backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)   ,
                  ),
                  child: AnimatedBuilder(
                    animation: _buttonAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _buttonAnimation.value,
                        child: child,
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.qr_code_scanner_rounded),
                        SizedBox(width: 8),
                        Text("Generate QR", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _shareQR();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ), backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 8),
                      Text("Share", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _generateQR() async {
    if (textController.text.isNotEmpty) {
      setState(() {
        isQRGenerating = true;
      });

      Security security = Security();
      Position position = await _determinePosition();
      String latitude = position.latitude.toString();
      String longitude = position.longitude.toString();
      String timestamp = DateTime.now().toString();
      String coordinates = '${textController.text}, $latitude, $longitude, $timestamp';
      String encryptedText = security.encryptString(coordinates);
      setState(() {
        qrData = encryptedText;
        isQRGenerating = false;
      });
    }
  }


  void _shareQR() async {
    if (qrData.isNotEmpty) {
      try {
        RenderRepaintBoundary boundary = qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        var image = await boundary.toImage(pixelRatio: 4.0);
        ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
        if (byteData != null) {
          Uint8List pngBytes = byteData.buffer.asUint8List();
          final tempDir = await getTemporaryDirectory();
          final file = File('${tempDir.path}/qr_code.png');
          await file.writeAsBytes(pngBytes);

          List<XFile> xFiles = [XFile(file.path)];
          await Share.shareXFiles(xFiles, text: textController.text);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      throw Exception("Location Services are disabled");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        throw Exception("Location Permissions are denied");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      throw Exception("Location Permissions are denied forever");
    }

    return await Geolocator.getCurrentPosition();
  }
}


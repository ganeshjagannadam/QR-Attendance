import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({super.key});

  @override
  GenerateQRPageState createState() => GenerateQRPageState();
}
class GenerateQRPageState extends State<GenerateQRPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR GENERATOR'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(
                data: controller.text,
                size: 300,
                embeddedImage: const AssetImage('images/javaImage.png'),
                embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(80,80)
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Enter Your RollNumber'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                    });
                  },
                  child: const Text('GENERATE QR')),
            ],
          ),
        ),
      ),
    );
  }
}

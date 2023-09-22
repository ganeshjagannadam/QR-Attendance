import 'package:flutter/material.dart';
import 'QR_Generator.dart';
import 'Colors_utils.dart';


class Attendance extends StatefulWidget{
  const Attendance({Key? key}) : super(key: key);

  @override
  AttendanceScreenState  createState() => AttendanceScreenState();
}

class AttendanceScreenState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Scan The Class QR ",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("87B0B5")],
                begin: Alignment.topCenter, end: Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                attendance(context,  (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GenerateQRPage()));
                }),
              ],
            ),
          ),
        ),
      ),
    );

  }
}

Container attendance(BuildContext context ,  Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton.icon(
      onPressed: (){
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.pressed)){
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))), icon : const Icon(Icons.qr_code_scanner_rounded),
              label: const Text(
       'ScanQR',
      style: TextStyle(
          color: Colors.black87 ,fontWeight: FontWeight.bold, fontSize: 16
      ),
    ),
    ),
  );
}

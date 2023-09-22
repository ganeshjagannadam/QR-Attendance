
import 'dart:io';
import 'dart:typed_data';
import 'package:qa/Server.dart';
import 'package:flutter/material.dart';
import 'Colors_utils.dart';
import 'Reusable_Widget.dart';


String ipAddress = ipAdd;
String portNumber = port;
dynamic ipA ;
dynamic soc ;
int pot = 0;

class Client extends StatefulWidget {
  const Client({super.key});

  @override
  _Client createState() => _Client();

}


class _Client extends State<Client>{

  final TextEditingController _ipTextController = TextEditingController();
  final TextEditingController _portTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     extendBodyBehindAppBar: true,
     appBar: AppBar(
       backgroundColor: Colors.black,
       elevation: 0,
       title: const Text(
         "Select Subjects",
         style:  TextStyle(color: Colors.white,
             fontSize: 24,
             fontStyle: FontStyle.normal,
             fontWeight: FontWeight.bold),
       ),
     ),
     body: Container(
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
             .height * 0.15, 20, 0),
             child:Column(
               children:  <Widget> [
                 reusableTextField(
                     "Enter IP Address", Icons.wifi, false,
                     _ipTextController),
                 const SizedBox(
                   height: 30,
                 ),
                 reusableTextField(
                     "Enter port Number", Icons.numbers, false,
                     _portTextController),
                 submit(context, (){
                   client();
                 })
               ],
             )
         ),
       ),
     ),
   );
  }


 Future client() async{
   ipA = _ipTextController.text;
   soc = _portTextController.text;
    final socket  = await Socket.connect(ipA.toString(), soc);
    if(await socket.isEmpty ){
        const Text("Port is not Open Please contact your Network Administrator",
            style: TextStyle(fontSize: 30,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),
          textAlign: TextAlign.end);
    }
    if(ipA == ipAddress && soc == portNumber){
        socket.listen((Uint8List data) {
        final serverResponse  = String.fromCharCodes(data);
         Text("Connected to: ${socket.remoteAddress.address}: $ipAddress: $port \n Client : $serverResponse",
            style: const TextStyle(fontSize: 30,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),
            textAlign: TextAlign.end);
      },
          onError: (error) {
            Text(error, style: const TextStyle(fontSize: 30,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
                textAlign: TextAlign.end);
            socket.destroy();
          },
          onDone: (){
            const  Text("Client : Server Left",
                style: TextStyle(fontSize: 30,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),
                textAlign: TextAlign.end);
            socket.destroy();
          }
      );
    }
    else{
       const Text("Port is not Open Please contact your Network Administrator",
            style: TextStyle(fontSize: 30,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),
           textAlign: TextAlign.end);
    }
    }
}

Container submit(BuildContext context , Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(75, 100, 75, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.pressed)){
              return Colors.white;
            }
            return Colors.black;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))), child: const Text(
      'Submit',
      style: TextStyle(
          color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 16
      ),
    ),
    ),
  );
}

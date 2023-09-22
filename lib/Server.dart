

import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Colors_utils.dart';

dynamic ipAdd ;
dynamic port ;


class Server extends StatefulWidget{
   const Server({super.key});
  @override
  _Server createState() => _Server();
}

class _Server extends State<Server>{
  Random random = Random();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     extendBodyBehindAppBar: true,
     appBar: AppBar(
       backgroundColor: Colors.black,
       elevation: 0,
       title:  const Text(
         "Server",
         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
       ),
     ),
     body: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
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
         child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
           child: Column(
             children: <Widget>[
               StuOrProButton(context, true, (){

                 server();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const ServerScreen()));
               }),
               StuOrProButton(context, false , (){

               })
             ],
           ),
         ),
       ),
     ),
   );
  }
  Container StuOrProButton(BuildContext context , bool isProf, Function onTap){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
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
              return Colors.black45;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))), child: Text(
        isProf ? 'Start Server' : 'Stop Server',
        style: const TextStyle(
            color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 16
        ),
      ),
      ),
    );
  }
  List<Socket> clients = [];
  Future server()async {

    final ip =  InternetAddress.anyIPv4;
    ipAdd = ip;
    port = random.nextInt(65535 - 1024);
    final server = (await ServerSocket.bind(ip, port));
    if (kDebugMode) {
      print("Server is running with $ip:$port");
    }
    server.listen((Socket event) {
    handleConnection(event);
    });
  }
  handleConnection(Socket client){
    client.listen((Uint8List data){
      final message = String.fromCharCodes(data);

      for(final c in clients){
        c.write("Server : $message joined the party");
      }
      clients.add(client);
      client.write("Server : You are logged in as $message");
    },
        onError: (error){
          if (kDebugMode) {
            print(error);
          }
          client.close();
        },
        onDone: (){
          if (kDebugMode) {
             const Text("Server: Client Left",
                 style: TextStyle(fontSize: 30,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),
                 textAlign: TextAlign.end);
          }
          client.close();
        }
    );
  }
}

class ServerScreen extends StatefulWidget {
  const ServerScreen ({super.key});

  @override
  _ServerScreen createState() => _ServerScreen();
}

class _ServerScreen extends State<ServerScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Log",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              hexStringToColor("FFFFFF")],
                begin: Alignment.topCenter, end: Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery
              .of(context)
              .size
              .height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
             Text("Server is running : $ipAdd:$port",
            style: const TextStyle(fontSize: 15,fontWeight:  FontWeight.bold,fontStyle: FontStyle.normal,
            color: Colors.black),textAlign: TextAlign.end)
              ],
            ),
          ),
        ),
      ),
    );
  }

}


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'Colors_utils.dart';

dynamic coordinates = "";
class Coordinates extends StatefulWidget{
  const Coordinates({super.key});

  @override
  _Coordinates createState() => _Coordinates();
}
class _Coordinates extends State<Coordinates>{
  dynamic latitude  = "";
  dynamic longitude = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: () async{
          Position position = await _determinePosition();
          setState((){
            latitude = position.latitude.toString();
            longitude = position.longitude.toString();
            coordinates = controller.text+','+latitude+','+longitude;
          });
          if (kDebugMode) {
            print("$latitude $longitude");
          }
      },
        backgroundColor: Colors.black,
        label: const Text("Generate QR"),
        shape:  BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5),
    ),
        icon: const Icon(Icons.qr_code_scanner_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
            "GPS Coordinates",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)
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
              children:  <Widget>[
                QrImage(
                  data: coordinates,
                  size: 300,
                  embeddedImageStyle: QrEmbeddedImageStyle(
                      size: const Size(80,80)
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Enter Subject Name'),
                  ),
                ),
                    ],
                  ),
                ),
            ),
          ),
    );
  }

  Future<Position> _determinePosition() async{
    bool serviceEnabled;
    LocationPermission locationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      Geolocator.openLocationSettings();
      return Future.error("Location Services re disabled");
    }
    locationPermission = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied){
        return Future.error("Location Permissions are denied");
      }
    }
    if(locationPermission == LocationPermission.deniedForever){
      return Future.error("Location Permissions are denied for ever, we cannot request the permission ");
    }
    return await Geolocator.getCurrentPosition();
  }

  Container elevatedButton(BuildContext context , Function onTap) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(75, 400, 75, 50),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white;
              }
              return Colors.black;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))), child: const Text(
        "Get Location",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16
        ),
      ),
      ),
    );
  }
}

// const Text("Coordinate Points",style: TextStyle(
//                     color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16
//                 )),
//                 const SizedBox(
//                   height: 10,
//                 ),
//               latitude!=null? Text("Latitude : $latitude",style: const TextStyle(
//                   color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16
//               )):
//               const SizedBox(
//                 height: 10,
//               ),
//                longitude!=null? Text("Longitude: $longitude",style: const TextStyle(
//                     color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16
//                 )):
//                const SizedBox(
//                  height: 10,
//                ),

import 'package:attandance_qr/Register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


String location = "";

class Location extends StatefulWidget{
  const Location({super.key});

  @override
  LocationScreen createState() => LocationScreen();
}

class LocationScreen extends State<Location>{
  List<String> locDetails = ["Alluri Sitharama Raju",
    "Anakapalli","Anantapuramu","Annamayya","Bapatla","Chittoor",
    "Dr. B.R. Ambedkar Konaseema","East Godavari","Eluru","Guntur",
    "Kakinada","Krishna","Kurnool","Nandyal","NTR","Palnadu",
    "Parvathipuram Manyam","Prakasam","Sri Potti Sriramulu Nellore",
    "Sri Sathya Sai","Srikakulam","Tirupati","Visakhapatnam","Vizianagaram","West Godavari","YSR"];

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Location",
          style: TextStyle(color: Colors.white,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
      ),
      body:ListView.builder(
          itemCount: locDetails.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.all(10),
            child: RadioListTile(
                     title:  Text(locDetails[index]),
                     value: locDetails[index],
                     groupValue: location,
                     onChanged: (value) {
                       setState(() {
                         location = value.toString();
                       });
                     }),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        location = location;
        setData();
        getData();
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Register()));
      },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward, color: Colors.white,),
      ),
    );
  }
  void getData() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    location = sp.getString('locData').toString();
    setState(() {

    });
  }
  void setData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('locData', location);
    setState(() {

    });
  }
}




// RadioListTile(
//                     title: const Text("Alluri Sitharama Raju"),
//                     value: "Alluri Sitharama Raju",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Anakapalli"),
//                     value: "Anakapalli",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Anantapuramu"),
//                     value: "Anantapuramu",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Annamayya"),
//                     value: "Annamayya",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Bapatla"),
//                     value: "Bapatla",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Chittoor"),
//                     value: "Chittoor",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Dr. B.R. Ambedkar Konaseema"),
//                     value: "Dr. B.R. Ambedkar Konaseema",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("East Godavari"),
//                     value: "East Godavari",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Eluru"),
//                     value: "Eluru",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Guntur"),
//                     value: "Guntur",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Kakinada"),
//                     value: "Kakinada",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Krishna"),
//                     value: "Krishna",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Kurnool"),
//                     value: "Kurnool",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Nandyal"),
//                     value: "Nandyal",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("NTR"),
//                     value: "NTR",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Palnadu"),
//                     value: "Palnadu",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Parvathipuram Manyam"),
//                     value: "Parvathipuram Manyam",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Prakasam"),
//                     value: "Prakasam",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Sri Potti Sriramulu Nellore"),
//                     value: "Sri Potti Sriramulu Nellore",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Sri Sathya Sai"),
//                     value: "Sri Sathya Sai",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Srikakulam"),
//                     value: "Srikakulam",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Tirupati"),
//                     value: "Tirupati",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Visakhapatnam"),
//                     value: "Visakhapatnam",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("Vizianagaram"),
//                     value: "Vizianagaram",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("West Godavari"),
//                     value: "West Godavari",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
//                 RadioListTile(
//                     title: const Text("YSR"),
//                     value: "YSR",
//                     groupValue: location,
//                     onChanged: (value) {
//                       setState(() {
//                         location = value.toString();
//                       });
//                     }),
// Container(
//         width: MediaQuery
//             .of(context)
//             .size
//             .width,
//         height: MediaQuery
//             .of(context)
//             .size
//             .height,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//               hexStringToColor("FFFFFF"),
//               hexStringToColor("FFFFFF"),
//               hexStringToColor("FFFFFF")
//             ],
//                 begin: Alignment.topCenter, end: Alignment.bottomCenter
//             )
//         ),
//         child: SingleChildScrollView(
//           child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery
//               .of(context)
//               .size
//               .height * 0.15, 20, 0),
//             child: Column(
//               children:  <Widget>[
//
//               ],
//             ),
//           ),
//         ),
//       ),



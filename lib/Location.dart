
import 'package:qa/Reg.dart';
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
            child: ListTile(
              tileColor: location == locDetails[index] ? Colors.grey[200] : null,
              onTap: () {
                setState(() {
                  location = locDetails[index];
                });
              },
              leading: Radio(
                value: locDetails[index],
                groupValue: location,
                onChanged: (value) {
                  setState(() {
                    location = value.toString();
                  });
                },
              ),
              title: Text(
                locDetails[index],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "Location description goes here",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              trailing: const Icon(
                Icons.location_on,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        location = location;
        setData();
        getData();
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const YearOfStudy()));
      },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward, color: Colors.white,),
      ),
    );
  }
  void getData() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    location = sp.getString('locData').toString();
  }
  void setData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('locData', location);
    setState(() {

    });
  }
}

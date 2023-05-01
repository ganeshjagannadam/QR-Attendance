
import 'package:flutter/material.dart';
import 'Branch.dart';
import 'Reg.dart';
import 'Result.dart';



List<List> branches = <List> [cse,ece,eee,civil];
List<String> cse = ["Data Structures","Operating System","Java","FLAT","Computer Networks"];
List<String> ece  = <String>["Control Systems",
"Analog Communication",
  "Analog Circuits",
  "DSP" ,
  "Satellite Communication" ,
  "Communication Systems"];
List<String> eee = <String>["Digital Logic Design",
  "DC Machines",
  "Electric Circuit Analysis",
  "Managerial Economics And Financial Analysis",
  "Power Electronics",
  "AC Machines",
  "ElectroMagnetic Field Theory "];
List<String> civil = <String>["Calculus and Linear Algebra",
  "Engineering Physics",
  "Basic Electrical Engineering",
  "Elements of Civil Engineering and Mechanics",
  "Engineering Graphics",
  "Engineering Physics Laboratory",
  "Technical English-I"];
Map<String, dynamic> subs = {
  "cse" : cse,
  "ece" : ece,
  "eee" : eee,
  "civil" : civil
};
String tapped = "";
List<String> branch = subs[course];
class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  DetailsPageScreen createState() => DetailsPageScreen();
}


class DetailsPageScreen extends State<DetailsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title:  Text(
          userName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
      body: ListView.builder(
                    itemCount: subs[course].length, // No of Rows
                  itemBuilder: (BuildContext context, int index) {
                   return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(branch[index],style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        onTap: (){
                          branch[index] = branch[index];
                          tapped =branch[index];
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Results() ));
                        },
                      ),
                    );
                  },
                    )
                );
  }
}
//ListView.builder(
//                  itemCount: subs[course].length, // No of Rows
//                  itemBuilder: (BuildContext context, int index) {
//                    return Card(
//                      margin: const EdgeInsets.all(10),
//                      child: ListTile(
//                        title: Text(branch[index],style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                        subtitle: ,
//                        onTap: (){
//                          branch[index] = branch[index];
//                          tapped =branch[index];
//                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Results() ));
//                        },
//                      ),
//                    );
//                  },
//         )
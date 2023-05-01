
import 'package:attandance_qr/SignUp_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Location.dart';
import 'Reg.dart';
import 'Signin_Screen.dart';

String course = "";
List<String> branches = ["CSE","ECE","EEE","Mechanical Engineering",
  "Computer Science and Business",
  "Robotics Engineering","Metallurgical Engineering","Telecommunication Engineering",
  "Telecommunication Engineering","Industrial Engineering","Biotechnology Engineering",
  "Automobile Engineering","Aerospace Engineering","Chemical Engineering","Civil Engineering","Mechanical Engineering"];
bool isVal = false;
int count = 0 ;
class Branch extends StatefulWidget{
  const Branch({super.key});

  @override
  BranchScreen createState() => BranchScreen();
}

class BranchScreen extends State<Branch> {
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: branches.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: RadioListTile(
                  title:  Text(branches[index]),
                  value: branches[index],
                  groupValue: course,
                  onChanged: (value) {
                    setState(() {
                      course = value.toString();
                      isVal = true;
                    });
                  }),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()  {
        course = course;
        if(count == 1){
          Fluttertoast.showToast(
              msg: "Registration Successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
        }
        else{
          if(isVal){
            count=1;
          }
          if (course == "CSE") {
            course = "cse";
            setData();
            getData();
            cse();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
          else if (course == "ECE") {
            course = "ece";
            setData();
            getData();
            ece();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
          else if (course == "Mechanical Engineering") {
            course = "mec";
            setData();
            getData();
            mec();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
          else if (course == "EEE") {
            course = "eee";
            setData();
            getData();
            eee();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
          else if (course == "Civil Engineering") {
            course = "civil";
            setData();
            getData();
            civil();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
        }

      },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward, color: Colors.white,),
      ),
    );
  }

  void getData() async{
     SharedPreferences sp = await SharedPreferences.getInstance();
        course = sp.getString('courseData').toString();
   }
   void setData() async {
     SharedPreferences sharedPref = await SharedPreferences.getInstance();
     sharedPref.setString('courseData', course);
     setState(() {

     });
  }


  cse(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location" : location,
      "email" : email,
      "Branch" : "cse",
      "Operating System" : [0,false],
      "Data Structures" : [0,false],
      "FLAT" : [0,false],
      "Computer Networks" : [0,false],
      "DBMS" : [0,false],
      "Mathematics 1" :[0,false],
      "Engineering Physics" :[0,false],
      "Basics of Electrical & Electronics Engineering" :[0,false],
      "Digital Logic Design" : [0,false],
      "Digital Systems" : [0,false],
      "Engineering Chemistry" : [0,false],
      "Programming with Python" : [0,false],
      "Java Programming" :[0,false],
      "Foundation of Computer Systems":[0,false],
      "Computer Organization & Architecture" :[0,false],
      "Computer Organisation ": [0,false],
      "Web Programming with Python and JavaScript" : [0,false],
      "Design and Analysis of Algorithms" : [0,false],
      "Fundamentals of Management" : [0,false],
      "Theory of Computation" : [0,false],
      "Quantitative Aptitude Reasoning" : [0,false],
      "Compiler Design": [0,false],
      "Artificial Intelligence" : [0,false],
      "Software Engineering" : [0,false],
      "Advanced Computer Architecture" :[0,false],
      "Natural Language Processing" :[0,false],
      "Data Warehousing and Data Mining" :[0,false],
      "Neural Network" :[0,false],
      "Cloud Computing" :[0,false],
      "Internet of Things": [0,false],
      "Machine Learning" :[0,false],
      "Calculus and Linear Algebra" :[0,false],
      "Engineering Physics Laboratory" :[0,false],
      "Basic Electrical Engineering Laboratory" :[0,false],
      "Technical English-I":[0,false],
      "C Programming For Problem Solving":[0,false],
      "Engineering Chemistry Laboratory":[0,false],
      "C Programming Laboratory":[0,false],
      "Advanced Calculus and Numerical Methods":[0,false],
      "Technical English-II":[0,false],
      "Cyber Security And Network Security":[0,false],
      "Discrete Mathematics And Graph Theory" :[0,false],
      "Software Engineering " :[0,false],
      "UNIX Programming" :[0,false],
      "Computer Graphics and Visualization":[0,false],
      "Cloud Computing and its Applications":[0,false],
      "Mobile Application Development":[0,false],
      "Data Analytics" : [0,false],
      "Probability And Statistics" :[0,false]
    };
    users.add(dataToSave);
  }

  ece(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {
      "name": studentName,
      "admission_No": userName,
      "location" : location,
      "email" : email,
      "Branch" : "ece",
      "Control Systems" : [0,false],
      "Analog Communication" : [0,false],
      "Analog Circuits" : [0,false],
      "DSP" : [0,false],
      "Satellite Communication" : [0,false],
      "Communication Systems" : [0,false],
      "Calculus and Linear Algebra" : [0,false],
      "Engineering Physics" :[0,false],
      "Basic Electrical Engineering":[0,false],
      'Elements of Civil Engineering and Mechanics':[0,false],
      'Engineering Graphics':[0,false],
      'Engineering Physics Laboratory' :[0,false],
      'Basic Electrical Engineering Laboratory':[0,false],
      'Technical English-I':[0,false],
      'Engineering Chemistry':[0,false],
      'C Programming For Problem Solving':[0,false],
      'Basic Electronics':[0,false],
      'Elements of Mechanical Engineering':[0,false],
      'Engineering Chemistry Laboratory':[0,false],
      'C Programming Laboratory':[0,false],
      'Advanced Calculus and Numerical Methods':[0,false],
      'Technical English-II':[0,false],
      'Mathematics' :[0,false],
      'Data Structures and Applications' :[0,false],
      'Analog and Digital Electronics' :[0,false],
      'Computer Organization' :[0,false],
      'Software Engineering' :[0,false],
      'Discrete Mathematical Structures' :[0,false],
      'Analog and Digital Electronics Laboratory' :[0,false],
      'Data Structures Laboratory' :[0,false],
      "Complex Analysis" :[0,false],
      "Probability and Statistical Methods" :[0,false],
      "Engineering Statistics & Linear Algebra" :[0,false],
      "Microcontroller" :[0,false],
      "Microcontroller Laboratory" :[0,false],
      "Analog Circuits Laboratory" :[0,false],
      "HDL Lab" :[0,false],
      "Principles of Communication Systems" :[0,false],
      "Information Theory & Coding" :[0,false],
      "Electromagnetic Waves" :[0,false],
      "Verilog HDL" :[0,false],
      "Digital Signal Processing Laboratory" :[0,false],
      "Digital Communication" :[0,false],
      "Embedded Systems" :[0,false],
      "Microwave & Antennas" :[0,false],
      "Embedded Systems Laboratory" :[0,false],
      "Communication Laboratory":[0,false],
      "Computer Networks" :[0,false],
      "VLSI Design" : [0,false],
      "Computer Networks Laboratory" :[0,false],
      "VLSI Laboratory" :[0,false],
    };
    users.add(dataToSave);
  }
  eee(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location" : location,
      "email" : email,
      "Branch" : "eee",
      "Digital Logic Design" : [0,false],
      "DC Machines" : [0,false],
      "Electric Circuit Analysis" : [0,false],
      "Managerial Economics And Financial Analysis" : [0,false],
      "Power Electronics" : [0,false],
      "AC Machines" : [0,false],
      "ElectroMagnetic Field Theory " : [0,false],
      "Analog Electronics" : [0,false],
      "PowerSystem Architecture" :[0,false],
      "Control Systems" : [0,false],
      "Digital Computer Platform" : [0,false],
      "Linear Digital Integrated Circuits Applications" : [0,false],
      "Embedded Systems" :[0,false],
      "Calculus & Differential Equations" :[0,false],
      "Engineering Physics":[0,false],
      "Basic Electrical Engineering":[0,false],
      "Elements of Civil Engineering and Mechanics":[0,false],
      "Engineering Visualization":[0,false],
      "Engineering Physics Laboratory":[0,false],
      "Basic Electrical Engineering Laboratory":[0,false],
      "Communicative English":[0,false],
      "Advanced Calculus and Numerical Methods":[0,false],
      "Engineering Chemistry":[0,false],
      "Problem-Solving through Programming":[0,false],
      "Basic Electronics & Communication Engineering":[0,false],
      "Elements of Mechanical Engineering":[0,false],
      "Engineering Chemistry Laboratory":[0,false],
      "Computer Programming Laboratory":[0,false],
      "Professional Writing Skills in English":[0,false],
      "Transform Calculus" :[0,false],
      "Fourier Series and Numerical Technics":[0,false],
      "Analog Electronic Circuits and Op – Amps":[0,false],
      "Transformers and Generators":[0,false],
      "Electrical Machines Laboratory – I":[0,false],
      "Complex Analysis, Probability and Statistical Methods":[0,false],
      "Digital System Design":[0,false],
      "Microcontroller":[0,false],
      "Electric Motors":[0,false],
      "Electrical Machine Laboratory – II":[0,false],
      "Switchgear and Protection":[0,false],
      "Transmission and Distribution":[0,false],
      "Power Electronics Laboratory":[0,false],
      "Power System Analysis – 1":[0,false],
      "Signals and Digital Signal Processing":[0,false],
      "Digital Signal Processing Laboratory":[0,false],
      "Power System Analysis – 2":[0,false]
    };
    users.add(dataToSave);
  }

  mec(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location": location,
      "email" : email,
      "Branch" : "mechanical",
      "Calculus and Linear Algebra":[0,false],
      "Engineering Physics":[0,false],
      "Basic Electrical Engineering":[0,false],
      "Elements of Civil Engineering and Mechanics":[0,false],
      "Engineering Graphics":[0,false],
      "Engineering Physics Laboratory":[0,false],
      "Technical English-I":[0,false],
      "Engineering Chemistry":[0,false],
      "C Programming For Problem Solving":[0,false],
      "Basic Electronics":[0,false],
      "Elements of Mechanical Engineering":[0,false],
      "Engineering Chemistry Laboratory":[0,false],
      "C Programming Laboratory":[0,false],
      "Advanced Calculus and Numerical Methods":[0,false],
      "Technical English-II":[0,false],
      "Transform calculus, Fourier series and Numerical techniques":[0,false],
      "Mechanics of Materials":[0,false],
      "Basic Thermodynamics":[0,false],
      "Material Science":[0,false],
      "Metal Cutting and Forming":[0,false],
      "Metal Casting and Welding":[0,false],
      "Computer Aided Machine Drawing":[0,false],
      "Material Testing Lab":[0,false],
      "Mechanical Measurements and Metrology lab":[0,false],
      "Workshop and Machine Shop Practice":[0,false],
      "Foundry, Forging and welding lab":[0,false],
      "Mathematics":[0,false],
      "Applied Thermodynamics":[0,false],
      "Fluid Mechanics":[0,false],
      "Kinematics of Machines":[0,false],
      "Design of Machine Elements I" :[0,false],
      "Dynamics of Machines":[0,false],
      "Turbo Machines":[0,false],
      "Fluid Power Engineering":[0,false],
      "Operations Management":[0,false],
      "Fluid Mechanics/Machines lab":[0,false],
      "Energy Conversion Lab":[0,false],
      "Finite Element Methods":[0,false],
      "Design of Machine Elements II":[0,false],
      "Heat Transfer":[0,false],
      "Control Engineering":[0,false],
      "Computer Aided Design and Manufacturing":[0,false],
      "Computer Integrated Manufacturing Lab":[0,false],
      "Internet of Things":[0,false],
    };
    users.add(dataToSave);
  }
  civil(){
      CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
      Map<String, dynamic> dataToSave =
      {"name": studentName,
        "admission_No": userName,
        "location":location,
        "email" : email,
        "Branch" : "civil",
        "Calculus and Linear Algebra":[0,false],
        "Engineering Physics":[0,false],
        "Basic Electrical Engineering":[0,false],
        "Elements of Civil Engineering and Mechanics":[0,false],
        "Engineering Graphics":[0,false],
        "Engineering Physics Laboratory":[0,false],
        "Technical English-I":[0,false],
        "Engineering Chemistry":[0,false],
        "C Programming For Problem Solving":[0,false],
        "Transform Calculus, Fourier Series and Numerical Techniques":[0,false],
        "Strength of Materials":[0,false],
        "Fluid Mechanics":[0,false],
        "Basic Materials and Construction":[0,false],
        "Basic Surveying":[0,false],
        "Engineering Geology":[0,false],
        "Computer Aided Building Planning & Drawing":[0,false],
        "Building Materials Testing Laboratory":[0,false],
        "Complex Analysis, Probability and Statistical Methods":[0,false],
        "Analysis of Determinate Structures":[0,false],
        "Applied Hydraulics":[0,false],
        "Concrete Technology":[0,false],
        "Advanced Surveying":[0,false],
        "Water Supply & Treatment Engineering":[0,false],
        "Engineering Geology Laboratory":[0,false],
        "Fluid Mechanics and Hydraulics Machines Laboratory":[0,false],
        "Construction Management & Entrepreneurship":[0,false],
        "Analysis of Indeterminate Structures":[0,false],
        "Design of RC Structural Elements":[0,false],
        "Basic Geotechnical Engineering":[0,false],
        "Municipal Wastewater Engineering":[0,false],
        "Highway Engineering":[0,false],
        "Surveying Practice":[0,false],
        "Concrete and Highway Materials Laboratory":[0,false],
        "Design of Steel Structural Elements":[0,false],
        "Applied Geotechnical Engineering":[0,false],
        "Hydrology and Irrigation Engineering":[0,false],
        "Professional Elective – 1":[0,false],
        "Open Elective – A":[0,false],
        "Software Application Laboratory":[0,false],
        "Quantity Surveying & Contract Management":[0,false],
        "Design of RCC and Steel Structures":[0,false],
        "Design of Pre-stressed Concrete":[0,false],
      };
      users.add(dataToSave);
  }
}
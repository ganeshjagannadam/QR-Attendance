
import 'package:qa/ProfilePicture.dart';
import 'package:qa/SignUp_Screen.dart';
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
  "Industrial Engineering","Biotechnology Engineering",
  "Automobile Engineering","Aerospace Engineering","Chemical Engineering","Civil Engineering"];
List<String> cs = [
  "Operating System", "Data Structures", "FLAT", "Computer Networks", "DBMS", "Mathematics 1", "Engineering Physics",
  "Basics of Electrical & Electronics Engineering", "Digital Logic Design", "Digital Systems", "Engineering Chemistry",
  "Programming with Python", "Java Programming", "Foundation of Computer Systems", "Computer Organization & Architecture",
  "Computer Organisation", "Web Programming with Python and JavaScript", "Design and Analysis of Algorithms",
  "Fundamentals of Management", "Theory of Computation", "Quantitative Aptitude Reasoning", "Compiler Design",
  "Artificial Intelligence", "Software Engineering", "Advanced Computer Architecture", "Natural Language Processing",
  "Data Warehousing and Data Mining", "Neural Network", "Cloud Computing", "Internet of Things", "Machine Learning",
  "Calculus and Linear Algebra", "Engineering Physics Laboratory", "Basic Electrical Engineering Laboratory",
  "Technical English-I", "C Programming For Problem Solving", "Engineering Chemistry Laboratory", "C Programming Laboratory",
  "Advanced Calculus and Numerical Methods", "Technical English-II", "Cyber Security And Network Security",
  "Discrete Mathematics And Graph Theory", "Software Engineering", "UNIX Programming", "Computer Graphics and Visualization",
  "Cloud Computing and its Applications", "Mobile Application Development", "Data Analytics", "Probability And Statistics"];
List<String> ec = ["Advanced Calculus and Numerical Methods", "Analog and Digital Electronics",
      "Analog and Digital Electronics Laboratory", "Analog Circuits",
      "Analog Circuits Laboratory", "Calculus and Linear Algebra",
      "Communication Laboratory", "Communication Systems",
      "Complex Analysis", "Computer Networks",
      "Computer Networks Laboratory", "Computer Organization",
      "Data Structures and Applications", "Data Structures Laboratory",
      "Digital Communication", "Digital Signal Processing Laboratory",
      "Discrete Mathematical Structures", "DSP",
      "Electromagnetic Waves", "Elements of Civil Engineering and Mechanics",
      "Elements of Mechanical Engineering", "Embedded Systems",
      "Embedded Systems Laboratory", "Engineering Chemistry",
      "Engineering Chemistry Laboratory", "Engineering Graphics",
      "Engineering Physics", "Engineering Physics Laboratory",
      "Engineering Statistics & Linear Algebra", "Information Theory & Coding",
      "Mathematics", "Microcontroller",
      "Microcontroller Laboratory", "Principles of Communication Systems",
      "Probability and Statistical Methods", "Software Engineering",
      "Technical English-I", "Technical English-II",
      "Verilog HDL", "VLSI Design",
      "VLSI Laboratory"];
List<String> ee = ["AC Machines", "Analog Electronic Circuits and Op – Amps", "Analog Electronics",
  "Basic Electrical Engineering","Basic Electrical Engineering Laboratory", "Basic Electronics & Communication Engineering",
  "Calculus & Differential Equations", "Communicative English",
  "Complex Analysis, Probability and Statistical Methods", "Computer Programming Laboratory",
  "Control Systems", "DC Machines",
  "Digital Computer Platform", "Digital Logic Design",
  "Digital Signal Processing Laboratory", "Digital System Design",
  "Electric Circuit Analysis", "Electric Motors",
  "Electrical Machine Laboratory – II", "Electrical Machines Laboratory – I",
  "ElectroMagnetic Field Theory", "Elements of Civil Engineering and Mechanics",
  "Elements of Mechanical Engineering", "Embedded Systems",
  "Engineering Chemistry", "Engineering Chemistry Laboratory",
  "Engineering Physics", "Engineering Physics Laboratory",
  "Engineering Visualization", "Fourier Series and Numerical Technics",
  "Linear Digital Integrated Circuits Applications", "Managerial Economics And Financial Analysis",
  "Microcontroller", "Power Electronics",
  "Power System Analysis – 1", "Power System Analysis – 2",
  "PowerSystem Architecture", "Professional Writing Skills in English",
  "Problem-Solving through Programming", "Signals and Digital Signal Processing",
  "Switchgear and Protection", "Transform Calculus",
  "Transformers and Generators", "Transmission and Distribution"];
List<String> me = ["Advanced Calculus and Numerical Methods", "Applied Thermodynamics", "Basic Electrical Engineering",
  "Basic Electronics", "Basic Thermodynamics", "C Programming For Problem Solving", "C Programming Laboratory",
  "Computer Aided Design and Manufacturing", "Computer Aided Machine Drawing", "Computer Integrated Manufacturing Lab",
  "Control Engineering", "Design of Machine Elements I", "Design of Machine Elements II", "Dynamics of Machines",
  "Elements of Civil Engineering and Mechanics", "Elements of Mechanical Engineering", "Engineering Chemistry",
  "Engineering Chemistry Laboratory", "Engineering Graphics", "Engineering Physics", "Engineering Physics Laboratory",
  "Finite Element Methods", "Fluid Mechanics", "Fluid Mechanics/Machines lab", "Fluid Power Engineering",
  "Foundry, Forging and welding lab", "Heat Transfer", "Internet of Things", "Kinematics of Machines",
  "Material Science", "Material Testing Lab", "Mathematics", "Mechanical Measurements and Metrology lab",
  "Mechanics of Materials", "Metal Casting and Welding", "Metal Cutting and Forming", "Operations Management",
  "Technical English-I", "Technical English-II", "Transform calculus, Fourier series and Numerical techniques",
  "Turbo Machines", "Workshop and Machine Shop Practice"];
List<String> civilengineering = [
  "Analysis of Determinate Structures", "Analysis of Indeterminate Structures", "Applied Geotechnical Engineering",
  "Applied Hydraulics", "Basic Electrical Engineering", "Basic Geotechnical Engineering", "Basic Materials and Construction",
  "Basic Surveying", "Building Materials Testing Laboratory", "Calculus and Linear Algebra",
  "Complex Analysis, Probability and Statistical Methods", "Concrete and Highway Materials Laboratory",
  "Concrete Technology", "Construction Management & Entrepreneurship", "Design of Pre-stressed Concrete",
  "Design of RCC and Steel Structures", "Design of RC Structural Elements", "Design of Steel Structural Elements",
  "Engineering Chemistry", "Engineering Geology", "Engineering Geology Laboratory", "Engineering Graphics",
  "Engineering Physics", "Engineering Physics Laboratory", "Fluid Mechanics", "Fluid Mechanics and Hydraulics Machines Laboratory",
  "Highway Engineering", "Hydrology and Irrigation Engineering", "Municipal Wastewater Engineering", "Open Elective – A",
  "Professional Elective – 1", "Quantity Surveying & Contract Management", "Software Application Laboratory",
  "Strength of Materials", "Surveying Practice", "Technical English-I",
  "Transform Calculus","Fourier Series and Numerical Techniques", "Water Supply & Treatment Engineering"];
List<String> csbusiness = ["Java Programming","C Programming","Python Programming","Data structures and algorithms","Database management systems","Operating systems","Computer networks",
  "Software engineering","Web development","Business and Management","Principles of management","Financial accounting",
  "Marketing management","Business communication","Business economics","Entrepreneurship and innovation",
  "Project management","Mathematics and Statistics","Calculus","Linear algebra","Probability and statistics",
  "Discrete mathematics","Electives and Specializations","Artificial intelligence","Data analytics and data science",
  "E-commerce and digital marketing","Supply chain management","Financial technology (FinTech)","Strategic management",
  "Operations research"];
List<String> robotic = ["Artificial Intelligence and Machine Learning",
  "Autonomous Systems", "Computer Vision", "Control Systems", "Digital Signal Processing",
  "Embedded Systems", "Human-Robot Interaction", "Introduction to Robotics", "Machine Learning for Robotics",
  "Mobile Robotics", "Robotic Manipulation", "Robotic Path Planning and Navigation", "Robotic Sensing and Perception",
  "Robot Ethics and Safety", "Robot Localization and Mapping", "Robot Design and Mechanisms", "Robot Programming",
  "Robotics and Automation in Manufacturing", "Robotics Kinematics and Dynamics", "Sensor and Actuator Systems"];
List<String> metallurgical = ["Alloy Design and Development", "Computational Materials Science", "Corrosion Science and Engineering",
  "Environmental Issues in Materials", "Extractive Metallurgy", "Failure Analysis and Prevention", "Heat Treatment of Metals",
  "Industrial Training and Internship", "Materials Characterization", "Materials Processing", "Materials Testing and Analysis",
  "Mechanical Behavior of Materials", "Metal Casting and Solidification", "Nanomaterials and Nanotechnology",
  "Phase Transformations", "Physical Metallurgy", "Powder Metallurgy", "Surface Engineering and Coatings",
  "Thermodynamics of Materials", "Welding Technology"];
List<String> telecommunications = ["Analog Communication Systems", "Digital Communication Systems",
  "Electromagnetic Field Theory", "Electronic Circuits", "Digital Signal Processing", "Microprocessors and Microcontrollers",
  "Antenna Theory and Design", "Wireless Communication Systems", "Optical Communication Systems",
  "Satellite Communication Systems", "Data Communication and Networking", "Mobile Communication Systems",
  "Telecommunication Switching Systems", "Information Theory and Coding", "Microwave Engineering", "Digital Image Processing",
  "RF and Microwave Design", "Communication Networks", "VLSI Design", "Embedded Systems"];
List<String> industrialengineering = ["Engineering Drawing and Graphics", "Engineering Economy", "Engineering Ethics and Professionalism",
  "Engineering Mathematics", "Engineering Mechanics", "Engineering Materials", "Facilities Planning and Design",
  "Human Factors Engineering", "Industrial Automation and Robotics", "Industrial Engineering Fundamentals",
  "Lean Manufacturing and Six Sigma", "Manufacturing Processes", "Operations Research", "Probability and Statistics for Engineers",
  "Production Planning and Control", "Project Management", "Quality Engineering and Management", "Supply Chain Management",
  "Sustainable Manufacturing", "Work System Design and Ergonomics"];
List<String> bioTech = ["Basic Electrical Engineering","Basic Mechanical Engineering","Biochemistry","Biocomputing",
  "Biomedical Engineering","Bioprocess Engineering","Biophysics","Bioreactors and Fermentation Technology",
  "Biosensors and Bioinstrumentation","Bioethics and Intellectual Property Rights","Bioinformatics","Cell Biology",
  "Engineering Chemistry","Engineering Graphics","Engineering Mathematics","Engineering Physics","Environmental Biotechnology",
  "Food Biotechnology","Genetic Engineering","Genetics","Immunology","Industrial Biotechnology","Microbiology","Molecular Biology",
  "Nanobiotechnology","Pharmaceutical Biotechnology","Plant and Animal Biotechnology","Biostatistics","Biotechnology Engineering",
  "Bioproduction and Downstream Processing"];
List<String> autoMobile = ["Automotive Business and Management", "Automotive Chassis", "Automotive Design and Manufacturing",
  "Automotive Diagnostics and Troubleshooting", "Automotive Electrical and Electronics Systems", "Automotive Engines",
  "Automotive Ergonomics and Human Factors Engineering", "Automotive Fuel and Emission Control Systems",
  "Automotive HVAC and Climate Control Systems", "Automotive Maintenance and Servicing", "Automotive Materials and Metallurgy",
  "Automotive Quality Management", "Automotive Regulations and Standards", "Automotive Safety and Crashworthiness",
  "Automotive Transmission Systems", "Automotive Vehicle Dynamics", "Engineering Graphics", "Engineering Mechanics",
  "Strength of Materials", "Thermodynamics", "Automotive Engineering Project"];
List<String> aeroSpace = [
  "Aerodynamics", "Aerospace Design and Analysis", "Aerospace Engineering Laboratory", "Aerospace Materials and Manufacturing",
  "Aerospace Structures and Materials", "Aerospace Vehicle Dynamics and Control", "Aircraft Performance and Operations",
  "Aircraft Propulsion", "Aircraft Stability and Control", "Avionics and Instrumentation", "Computational Fluid Dynamics",
  "Engineering Mechanics", "Flight Dynamics and Control", "Introduction to Aerospace Engineering",
  "Mathematics for Aerospace Engineers", "Physics for Aerospace Engineers", "Rocket Propulsion",
  "Space Mechanics and Orbital Dynamics", "Spacecraft Design and Operations", "Spacecraft Propulsion Systems",
  "Spacecraft Systems Engineering"];
List<String> chemicals = ["Chemical Process Calculations", "Chemical Reaction Engineering", "Chemical Thermodynamics",
  "Chemical Engineering Laboratory", "Chemical Engineering Principles", "Chemical Engineering Thermodynamics",
  "Chemical Process Industries", "Chemical Process Technology", "Chemical Process Control", "Chemical Engineering Design",
  "Fluid Mechanics and Heat Transfer", "Heat Transfer Operations", "Mass Transfer Operations", "Process Dynamics and Control",
  "Process Equipment Design", "Process Modeling and Simulation", "Process Safety and Hazards", "Separation Processes",
  "Transport Phenomena"];
bool isVal = false;
int count = 0 ;
class Branch extends StatefulWidget{
  const Branch({super.key});

  @override
  BranchScreen createState() => BranchScreen();
}

class BranchScreen extends State<Branch>
    with SingleTickerProviderStateMixin {
  late SharedPreferences sharedPreferences;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: branches.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return ListTile(
                  tileColor: course == branches[index] ? Colors.grey[200] : null,
                  onTap: () {
                    setState(() {
                      course = branches[index];
                      isVal = true;
                      if (_animationController.status !=
                          AnimationStatus.forward) {
                        _animationController.forward();
                      }
                    });
                  },
                  leading: course == branches[index]
                      ? ScaleTransition(
                    scale: _scaleAnimation,
                    child: Icon(
                      getCourseIcon(branches[index]),
                      color: Colors.black,
                    ),
                  )
                      : Icon(
                    getCourseIcon(branches[index]),
                    color: Colors.black,
                  ),
                  title: Text(
                    branches[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          );
        },
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
        else {
          if (isVal) {
            count = 1;
          }
          if (course == "CSE") {
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
          else if (course == "ECE") {
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
          else if (course == "Mechanical Engineering") {
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
          else if (course == "EEE") {
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
          else if (course == "Civil Engineering") {
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          }
          else if (course == "Computer Science and Business") {
            setData();
            getData();
            csb();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          } else if (course == "Robotics Engineering") {
            setData();
            getData();
            robotics();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          } else if (course == "Metallurgical Engineering") {
            setData();
            getData();
            metallurgy();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          } else if (course == "Telecommunication Engineering") {
            setData();
            getData();
            telecommunication();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          } else if (course == "Industrial Engineering") {
            setData();
            getData();
            industrial();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          } else if (course == "Biotechnology Engineering") {
            setData();
            getData();
            bioTechnology();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          } else if (course == "Automobile Engineering") {
            setData();
            getData();
            automobile();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          } else if (course == "Aerospace Engineering") {
            setData();
            getData();
            aerospace();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else if (course == "Chemical Engineering") {
            setData();
            getData();
            chemical();
            Fluttertoast.showToast(
                msg: "Registration Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      },
        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_forward, color: Colors.white,),
      ),
    );
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  IconData getCourseIcon(String course) {
    switch (course) {
      case "CSE":
        return Icons.computer;
      case "ECE":
        return Icons.memory_outlined;
      case "EEE":
        return Icons.lightbulb;
      case "Mechanical Engineering":
        return Icons.engineering;
      case "Computer Science and Business":
        return Icons.business_center;
      case "Robotics Engineering":
        return Icons.android;
      case "Metallurgical Engineering":
        return Icons.account_tree;
      case "Telecommunication Engineering":
        return Icons.wifi;
      case "Industrial Engineering":
        return Icons.construction;
      case "Biotechnology Engineering":
        return Icons.spa;
      case "Automobile Engineering":
        return Icons.directions_car;
      case "Aerospace Engineering":
        return Icons.airplanemode_active;
      case "Chemical Engineering":
        return Icons.science;
      case "Civil Engineering":
        return Icons.architecture;
      default:
        return Icons.school;
    }
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
    {
      "name": studentName,
      "admission_No": userName,
      "location" : location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Operating System": 0,
      "Data Structures": 0,
      "FLAT": 0,
      "Computer Networks": 0,
      "DBMS": 0,
      "Mathematics 1": 0,
      "Engineering Physics": 0,
      "Basics of Electrical & Electronics Engineering": 0,
      "Digital Logic Design": 0,
      "Digital Systems": 0,
      "Engineering Chemistry": 0,
      "Programming with Python": 0,
      "Java Programming": 0,
      "Foundation of Computer Systems": 0,
      "Computer Organization & Architecture": 0,
      "Computer Organisation": 0,
      "Web Programming with Python and JavaScript": 0,
      "Design and Analysis of Algorithms": 0,
      "Fundamentals of Management": 0,
      "Theory of Computation": 0,
      "Quantitative Aptitude Reasoning": 0,
      "Compiler Design": 0,
      "Artificial Intelligence": 0,
      "Software Engineering": 0,
      "Advanced Computer Architecture": 0,
      "Natural Language Processing": 0,
      "Data Warehousing and Data Mining": 0,
      "Neural Network": 0,
      "Cloud Computing": 0,
      "Internet of Things": 0,
      "Machine Learning": 0,
      "Calculus and Linear Algebra": 0,
      "Engineering Physics Laboratory": 0,
      "Basic Electrical Engineering Laboratory": 0,
      "Technical English-I": 0,
      "C Programming For Problem Solving": 0,
      "Engineering Chemistry Laboratory": 0,
      "C Programming Laboratory": 0,
      "Advanced Calculus and Numerical Methods": 0,
      "Technical English-II": 0,
      "Cyber Security And Network Security": 0,
      "Discrete Mathematics And Graph Theory": 0,
      "UNIX Programming": 0,
      "Computer Graphics and Visualization": 0,
      "Cloud Computing and its Applications": 0,
      "Mobile Application Development": 0,
      "Data Analytics": 0,
      "Probability And Statistics": 0,
      "subjects" : {
        "Operating System": false,
        "Data Structures": false,
        "FLAT": false,
        "Computer Networks": false,
        "DBMS": false,
        "Mathematics 1": false,
        "Engineering Physics": false,
        "Basics of Electrical & Electronics Engineering": false,
        "Digital Logic Design": false,
        "Digital Systems": false,
        "Engineering Chemistry": false,
        "Programming with Python": false,
        "Java Programming": false,
        "Foundation of Computer Systems": false,
        "Computer Organization & Architecture": false,
        "Computer Organisation": false,
        "Web Programming with Python and JavaScript": false,
        "Design and Analysis of Algorithms": false,
        "Fundamentals of Management": false,
        "Theory of Computation": false,
        "Quantitative Aptitude Reasoning": false,
        "Compiler Design": false,
        "Artificial Intelligence": false,
        "Software Engineering": false,
        "Advanced Computer Architecture": false,
        "Natural Language Processing": false,
        "Data Warehousing and Data Mining": false,
        "Neural Network": false,
        "Cloud Computing": false,
        "Internet of Things": false,
        "Machine Learning": false,
        "Calculus and Linear Algebra": false,
        "Engineering Physics Laboratory": false,
        "Basic Electrical Engineering Laboratory": false,
        "Technical English-I": false,
        "C Programming For Problem Solving": false,
        "Engineering Chemistry Laboratory": false,
        "C Programming Laboratory": false,
        "Advanced Calculus and Numerical Methods": false,
        "Technical English-II": false,
        "Cyber Security And Network Security": false,
        "Discrete Mathematics And Graph Theory": false,
        "UNIX Programming": false,
        "Computer Graphics and Visualization": false,
        "Cloud Computing and its Applications": false,
        "Mobile Application Development": false,
        "Data Analytics": false,
        "Probability And Statistics": false,
      },
     "subs" : cs
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
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Advanced Calculus and Numerical Methods": 0,
      "Analog and Digital Electronics": 0,
      "Analog and Digital Electronics Laboratory": 0,
      "Analog Circuits": 0,
      "Analog Circuits Laboratory": 0,
      "Calculus and Linear Algebra": 0,
      "Communication Laboratory": 0,
      "Communication Systems": 0,
      "Complex Analysis": 0,
      "Computer Networks": 0,
      "Computer Networks Laboratory": 0,
      "Computer Organization": 0,
      "Data Structures and Applications": 0,
      "Data Structures Laboratory": 0,
      "Digital Communication": 0,
      "Digital Signal Processing Laboratory": 0,
      "Discrete Mathematical Structures": 0,
      "DSP": 0,
      "Electromagnetic Waves": 0,
      "Elements of Civil Engineering and Mechanics": 0,
      "Elements of Mechanical Engineering": 0,
      "Embedded Systems": 0,
      "Embedded Systems Laboratory": 0,
      "Engineering Chemistry": 0,
      "Engineering Chemistry Laboratory": 0,
      "Engineering Graphics": 0,
      "Engineering Physics": 0,
      "Engineering Physics Laboratory": 0,
      "Engineering Statistics & Linear Algebra": 0,
      "Information Theory & Coding": 0,
      "Mathematics": 0,
      "Microcontroller": 0,
      "Microcontroller Laboratory": 0,
      "Principles of Communication Systems": 0,
      "Probability and Statistical Methods": 0,
      "Software Engineering": 0,
      "Technical English-I": 0,
      "Technical English-II": 0,
      "Verilog HDL": 0,
      "VLSI Design": 0,
      "VLSI Laboratory": 0,
      "subjects" : {
        "Advanced Calculus and Numerical Methods": false,
        "Analog and Digital Electronics": false,
        "Analog and Digital Electronics Laboratory": false,
        "Analog Circuits": false,
        "Analog Circuits Laboratory": false,
        "Calculus and Linear Algebra": false,
        "Communication Laboratory": false,
        "Communication Systems": false,
        "Complex Analysis": false,
        "Computer Networks": false,
        "Computer Networks Laboratory": false,
        "Computer Organization": false,
        "Data Structures and Applications": false,
        "Data Structures Laboratory": false,
        "Digital Communication": false,
        "Digital Signal Processing Laboratory": false,
        "Discrete Mathematical Structures": false,
        "DSP": false,
        "Electromagnetic Waves": false,
        "Elements of Civil Engineering and Mechanics": false,
        "Elements of Mechanical Engineering": false,
        "Embedded Systems": false,
        "Embedded Systems Laboratory": false,
        "Engineering Chemistry": false,
        "Engineering Chemistry Laboratory": false,
        "Engineering Graphics": false,
        "Engineering Physics": false,
        "Engineering Physics Laboratory": false,
        "Engineering Statistics & Linear Algebra": false,
        "Information Theory & Coding": false,
        "Mathematics": false,
        "Microcontroller": false,
        "Microcontroller Laboratory": false,
        "Principles of Communication Systems": false,
        "Probability and Statistical Methods": false,
        "Software Engineering": false,
        "Technical English-I": false,
        "Technical English-II": false,
        "Verilog HDL": false,
        "VLSI Design": false,
        "VLSI Laboratory": false,
      },
    "subs" : ec
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
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "AC Machines": 0,
      "Analog Electronic Circuits and Op – Amps": 0,
      "Analog Electronics": 0,
      "Basic Electrical Engineering": 0,
      "Basic Electrical Engineering Laboratory": 0,
      "Basic Electronics & Communication Engineering": 0,
      "Calculus & Differential Equations": 0,
      "Communicative English": 0,
      "Complex Analysis, Probability and Statistical Methods": 0,
      "Computer Programming Laboratory": 0,
      "Control Systems": 0,
      "DC Machines": 0,
      "Digital Computer Platform": 0,
      "Digital Logic Design": 0,
      "Digital Signal Processing Laboratory": 0,
      "Digital System Design": 0,
      "Electric Circuit Analysis": 0,
      "Electric Motors": 0,
      "Electrical Machine Laboratory – II": 0,
      "Electrical Machines Laboratory – I": 0,
      "ElectroMagnetic Field Theory": 0,
      "Elements of Civil Engineering and Mechanics": 0,
      "Elements of Mechanical Engineering": 0,
      "Embedded Systems": 0,
      "Engineering Chemistry": 0,
      "Engineering Chemistry Laboratory": 0,
      "Engineering Physics": 0,
      "Engineering Physics Laboratory": 0,
      "Engineering Visualization": 0,
      "Fourier Series and Numerical Technics": 0,
      "Linear Digital Integrated Circuits Applications": 0,
      "Managerial Economics And Financial Analysis": 0,
      "Microcontroller": 0,
      "Power Electronics": 0,
      "Power System Analysis – 1": 0,
      "Power System Analysis – 2": 0,
      "PowerSystem Architecture": 0,
      "Professional Writing Skills in English": 0,
      "Problem-Solving through Programming": 0,
      "Signals and Digital Signal Processing": 0,
      "Switchgear and Protection": 0,
      "Transform Calculus": 0,
      "Transformers and Generators": 0,
      "Transmission and Distribution": 0,
      "subjects" : {
        "AC Machines": false,
        "Analog Electronic Circuits and Op – Amps": false,
        "Analog Electronics": false,
        "Basic Electrical Engineering": false,
        "Basic Electrical Engineering Laboratory": false,
        "Basic Electronics & Communication Engineering": false,
        "Calculus & Differential Equations": false,
        "Communicative English": false,
        "Complex Analysis, Probability and Statistical Methods": false,
        "Computer Programming Laboratory": false,
        "Control Systems": false,
        "DC Machines": false,
        "Digital Computer Platform": false,
        "Digital Logic Design": false,
        "Digital Signal Processing Laboratory": false,
        "Digital System Design": false,
        "Electric Circuit Analysis": false,
        "Electric Motors": false,
        "Electrical Machine Laboratory – II": false,
        "Electrical Machines Laboratory – I": false,
        "ElectroMagnetic Field Theory": false,
        "Elements of Civil Engineering and Mechanics": false,
        "Elements of Mechanical Engineering": false,
        "Embedded Systems": false,
        "Engineering Chemistry": false,
        "Engineering Chemistry Laboratory": false,
        "Engineering Physics": false,
        "Engineering Physics Laboratory": false,
        "Engineering Visualization": false,
        "Fourier Series and Numerical Technics": false,
        "Linear Digital Integrated Circuits Applications": false,
        "Managerial Economics And Financial Analysis": false,
        "Microcontroller": false,
        "Power Electronics": false,
        "Power System Analysis – 1": false,
        "Power System Analysis – 2": false,
        "PowerSystem Architecture": false,
        "Professional Writing Skills in English": false,
        "Problem-Solving through Programming": false,
        "Signals and Digital Signal Processing": false,
        "Switchgear and Protection": false,
        "Transform Calculus": false,
        "Transformers and Generators": false,
        "Transmission and Distribution": false,
      },
    "subs" : ee
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
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Advanced Calculus and Numerical Methods": 0,
      "Applied Thermodynamics": 0,
      "Basic Electrical Engineering": 0,
      "Basic Electronics": 0,
      "Basic Thermodynamics": 0,
      "C Programming For Problem Solving": 0,
      "C Programming Laboratory": 0,
      "Computer Aided Design and Manufacturing": 0,
      "Computer Aided Machine Drawing": 0,
      "Computer Integrated Manufacturing Lab": 0,
      "Control Engineering": 0,
      "Design of Machine Elements I": 0,
      "Design of Machine Elements II": 0,
      "Dynamics of Machines": 0,
      "Elements of Civil Engineering and Mechanics": 0,
      "Elements of Mechanical Engineering": 0,
      "Engineering Chemistry": 0,
      "Engineering Chemistry Laboratory": 0,
      "Engineering Graphics": 0,
      "Engineering Physics": 0,
      "Engineering Physics Laboratory": 0,
      "Finite Element Methods": 0,
      "Fluid Mechanics": 0,
      "Fluid Mechanics/Machines lab": 0,
      "Fluid Power Engineering": 0,
      "Foundry, Forging and welding lab": 0,
      "Heat Transfer": 0,
      "Internet of Things": 0,
      "Kinematics of Machines": 0,
      "Material Science": 0,
      "Material Testing Lab": 0,
      "Mathematics": 0,
      "Mechanical Measurements and Metrology lab": 0,
      "Mechanics of Materials": 0,
      "Metal Casting and Welding": 0,
      "Metal Cutting and Forming": 0,
      "Operations Management": 0,
      "Technical English-I": 0,
      "Technical English-II": 0,
      "Transform calculus, Fourier series and Numerical techniques": 0,
      "Turbo Machines": 0,
      "Workshop and Machine Shop Practice": 0,
      "subjects" : {
        "Advanced Calculus and Numerical Methods": false,
        "Applied Thermodynamics": false,
        "Basic Electrical Engineering": false,
        "Basic Electronics": false,
        "Basic Thermodynamics": false,
        "C Programming For Problem Solving": false,
        "C Programming Laboratory": false,
        "Computer Aided Design and Manufacturing": false,
        "Computer Aided Machine Drawing": false,
        "Computer Integrated Manufacturing Lab": false,
        "Control Engineering": false,
        "Design of Machine Elements I": false,
        "Design of Machine Elements II": false,
        "Dynamics of Machines": false,
        "Elements of Civil Engineering and Mechanics": false,
        "Elements of Mechanical Engineering": false,
        "Engineering Chemistry": false,
        "Engineering Chemistry Laboratory": false,
        "Engineering Graphics": false,
        "Engineering Physics": false,
        "Engineering Physics Laboratory": false,
        "Finite Element Methods": false,
        "Fluid Mechanics": false,
        "Fluid Mechanics/Machines lab": false,
        "Fluid Power Engineering": false,
        "Foundry, Forging and welding lab": false,
        "Heat Transfer": false,
        "Internet of Things": false,
        "Kinematics of Machines": false,
        "Material Science": false,
        "Material Testing Lab": false,
        "Mathematics": false,
        "Mechanical Measurements and Metrology lab": false,
        "Mechanics of Materials": false,
        "Metal Casting and Welding": false,
        "Metal Cutting and Forming": false,
        "Operations Management": false,
        "Technical English-I": false,
        "Technical English-II": false,
        "Transform calculus, Fourier series and Numerical techniques": false,
        "Turbo Machines": false,
        "Workshop and Machine Shop Practice": false,
      },
    "subs" : me
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
        "college" : university,
        "year" : yearOfStudy,
        "Branch" : course,
        'profilePic' : profURL,
        "Analysis of Determinate Structures": 0,
        "Analysis of Indeterminate Structures": 0,
        "Applied Geotechnical Engineering": 0,
        "Applied Hydraulics": 0,
        "Basic Electrical Engineering": 0,
        "Basic Geotechnical Engineering": 0,
        "Basic Materials and Construction": 0,
        "Basic Surveying": 0,
        "Building Materials Testing Laboratory": 0,
        "Calculus and Linear Algebra": 0,
        "Complex Analysis, Probability and Statistical Methods": 0,
        "Concrete and Highway Materials Laboratory": 0,
        "Concrete Technology": 0,
        "Construction Management & Entrepreneurship": 0,
        "Design of Pre-stressed Concrete": 0,
        "Design of RCC and Steel Structures": 0,
        "Design of RC Structural Elements": 0,
        "Design of Steel Structural Elements": 0,
        "Engineering Chemistry": 0,
        "Engineering Geology": 0,
        "Engineering Geology Laboratory": 0,
        "Engineering Graphics": 0,
        "Engineering Physics": 0,
        "Engineering Physics Laboratory": 0,
        "Fluid Mechanics": 0,
        "Fluid Mechanics and Hydraulics Machines Laboratory": 0,
        "Highway Engineering": 0,
        "Hydrology and Irrigation Engineering": 0,
        "Municipal Wastewater Engineering": 0,
        "Open Elective – A": 0,
        "Professional Elective – 1": 0,
        "Quantity Surveying & Contract Management": 0,
        "Software Application Laboratory": 0,
        "Strength of Materials": 0,
        "Surveying Practice": 0,
        "Technical English-I": 0,
        "Transform Calculus": 0,
        "Fourier Series and Numerical Techniques": 0,
        "Water Supply & Treatment Engineering": 0,
        "subjects" : {
          "Analysis of Determinate Structures": false,
          "Analysis of Indeterminate Structures": false,
          "Applied Geotechnical Engineering": false,
          "Applied Hydraulics": false,
          "Basic Electrical Engineering": false,
          "Basic Geotechnical Engineering": false,
          "Basic Materials and Construction": false,
          "Basic Surveying": false,
          "Building Materials Testing Laboratory": false,
          "Calculus and Linear Algebra": false,
          "Complex Analysis, Probability and Statistical Methods": false,
          "Concrete and Highway Materials Laboratory": false,
          "Concrete Technology": false,
          "Construction Management & Entrepreneurship": false,
          "Design of Pre-stressed Concrete": false,
          "Design of RCC and Steel Structures": false,
          "Design of RC Structural Elements": false,
          "Design of Steel Structural Elements": false,
          "Engineering Chemistry": false,
          "Engineering Geology": false,
          "Engineering Geology Laboratory": false,
          "Engineering Graphics": false,
          "Engineering Physics": false,
          "Engineering Physics Laboratory": false,
          "Fluid Mechanics": false,
          "Fluid Mechanics and Hydraulics Machines Laboratory": false,
          "Highway Engineering": false,
          "Hydrology and Irrigation Engineering": false,
          "Municipal Wastewater Engineering": false,
          "Open Elective – A": false,
          "Professional Elective – 1": false,
          "Quantity Surveying & Contract Management": false,
          "Software Application Laboratory": false,
          "Strength of Materials": false,
          "Surveying Practice": false,
          "Technical English-I": false,
          "Transform Calculus": false,
          "Fourier Series and Numerical Techniques": false,
          "Water Supply & Treatment Engineering": false,
        },
      "subs" : civilengineering
      };
      users.add(dataToSave);
  }

  csb(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location":location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Java Programming": 0,
      "C Programming": 0,
      "Python Programming": 0,
      "Data structures and algorithms": 0,
      "Database management systems": 0,
      "Operating systems": 0,
      "Computer networks": 0,
      "Software engineering": 0,
      "Web development": 0,
      "Business and Management": 0,
      "Principles of management": 0,
      "Financial accounting": 0,
      "Marketing management": 0,
      "Business communication": 0,
      "Business economics": 0,
      "Entrepreneurship and innovation": 0,
      "Project management": 0,
      "Mathematics and Statistics": 0,
      "Calculus": 0,
      "Linear algebra": 0,
      "Probability and statistics": 0,
      "Discrete mathematics": 0,
      "Electives and Specializations": 0,
      "Artificial intelligence": 0,
      "Data analytics and data science": 0,
      "E-commerce and digital marketing": 0,
      "Supply chain management": 0,
      "Financial technology (FinTech)": 0,
      "Strategic management": 0,
      "subjects" : {
        "Java Programming": false,
        "C Programming": false,
        "Python Programming": false,
        "Data structures and algorithms": false,
        "Database management systems": false,
        "Operating systems": false,
        "Computer networks": false,
        "Software engineering": false,
        "Web development": false,
        "Business and Management": false,
        "Principles of management": false,
        "Financial accounting": false,
        "Marketing management": false,
        "Business communication": false,
        "Business economics": false,
        "Entrepreneurship and innovation": false,
        "Project management": false,
        "Mathematics and Statistics": false,
        "Calculus": false,
        "Linear algebra": false,
        "Probability and statistics": false,
        "Discrete mathematics": false,
        "Electives and Specializations": false,
        "Artificial intelligence": false,
        "Data analytics and data science": false,
        "E-commerce and digital marketing": false,
        "Supply chain management": false,
        "Financial technology (FinTech)": false,
        "Strategic management": false,
      },
    "subs" : csbusiness
    };
    users.add(dataToSave);
  }
  robotics(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location":location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Artificial Intelligence and Machine Learning": 0,
      "Autonomous Systems": 0,
      "Computer Vision": 0,
      "Control Systems": 0,
      "Digital Signal Processing": 0,
      "Embedded Systems": 0,
      "Human-Robot Interaction": 0,
      "Introduction to Robotics": 0,
      "Machine Learning for Robotics": 0,
      "Mobile Robotics": 0,
      "Robotic Manipulation": 0,
      "Robotic Path Planning and Navigation": 0,
      "Robotic Sensing and Perception": 0,
      "Robot Ethics and Safety": 0,
      "Robot Localization and Mapping": 0,
      "Robot Design and Mechanisms": 0,
      "Robot Programming": 0,
      "Robotics and Automation in Manufacturing": 0,
      "Robotics Kinematics and Dynamics": 0,
      "Sensor and Actuator Systems": 0,
      "subjects" : {
        "Artificial Intelligence and Machine Learning": false,
        "Autonomous Systems": false,
        "Computer Vision": false,
        "Control Systems": false,
        "Digital Signal Processing": false,
        "Embedded Systems": false,
        "Human-Robot Interaction": false,
        "Introduction to Robotics": false,
        "Machine Learning for Robotics": false,
        "Mobile Robotics": false,
        "Robotic Manipulation": false,
        "Robotic Path Planning and Navigation": false,
        "Robotic Sensing and Perception": false,
        "Robot Ethics and Safety": false,
        "Robot Localization and Mapping": false,
        "Robot Design and Mechanisms": false,
        "Robot Programming": false,
        "Robotics and Automation in Manufacturing": false,
        "Robotics Kinematics and Dynamics": false,
        "Sensor and Actuator Systems": false
      },
    "subs" : robotic
    };
    users.add(dataToSave);
  }

  metallurgy(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location":location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Alloy Design and Development": 0,
      "Computational Materials Science": 0,
      "Corrosion Science and Engineering": 0,
      "Environmental Issues in Materials": 0,
      "Extractive Metallurgy": 0,
      "Failure Analysis and Prevention": 0,
      "Heat Treatment of Metals": 0,
      "Industrial Training and Internship": 0,
      "Materials Characterization": 0,
      "Materials Processing": 0,
      "Materials Testing and Analysis": 0,
      "Mechanical Behavior of Materials": 0,
      "Metal Casting and Solidification": 0,
      "Nanomaterials and Nanotechnology": 0,
      "Phase Transformations": 0,
      "Physical Metallurgy": 0,
      "Powder Metallurgy": 0,
      "Surface Engineering and Coatings": 0,
      "Thermodynamics of Materials": 0,
      "Welding Technology": 0,
      "subjects" : {
        "Alloy Design and Development": false,
        "Computational Materials Science": false,
        "Corrosion Science and Engineering": false,
        "Environmental Issues in Materials": false,
        "Extractive Metallurgy": false,
        "Failure Analysis and Prevention": false,
        "Heat Treatment of Metals": false,
        "Industrial Training and Internship": false,
        "Materials Characterization": false,
        "Materials Processing": false,
        "Materials Testing and Analysis": false,
        "Mechanical Behavior of Materials": false,
        "Metal Casting and Solidification": false,
        "Nanomaterials and Nanotechnology": false,
        "Phase Transformations": false,
        "Physical Metallurgy": false,
        "Powder Metallurgy": false,
        "Surface Engineering and Coatings": false,
        "Thermodynamics of Materials": false,
        "Welding Technology": false
      },
    "subs" : metallurgical
    };
    users.add(dataToSave);
  }


  telecommunication(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location":location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Analog Communication Systems": 0,
      "Digital Communication Systems": 0,
      "Electromagnetic Field Theory": 0,
      "Electronic Circuits": 0,
      "Digital Signal Processing": 0,
      "Microprocessors and Microcontrollers": 0,
      "Antenna Theory and Design": 0,
      "Wireless Communication Systems": 0,
      "Optical Communication Systems": 0,
      "Satellite Communication Systems": 0,
      "Data Communication and Networking": 0,
      "Mobile Communication Systems": 0,
      "Telecommunication Switching Systems": 0,
      "Information Theory and Coding": 0,
      "Microwave Engineering": 0,
      "Digital Image Processing": 0,
      "RF and Microwave Design": 0,
      "Communication Networks": 0,
      "VLSI Design": 0,
      "Embedded Systems": 0,
      "subjects" : {
        "Analog Communication Systems": false,
        "Digital Communication Systems": false,
        "Electromagnetic Field Theory": false,
        "Electronic Circuits": false,
        "Digital Signal Processing": false,
        "Microprocessors and Microcontrollers": false,
        "Antenna Theory and Design": false,
        "Wireless Communication Systems": false,
        "Optical Communication Systems": false,
        "Satellite Communication Systems": false,
        "Data Communication and Networking": false,
        "Mobile Communication Systems": false,
        "Telecommunication Switching Systems": false,
        "Information Theory and Coding": false,
        "Microwave Engineering": false,
        "Digital Image Processing": false,
        "RF and Microwave Design": false,
        "Communication Networks": false,
        "VLSI Design": false,
        "Embedded Systems": false
      },
    "subs" : telecommunications
    };
    users.add(dataToSave);
  }

  industrial(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location":location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Engineering Drawing and Graphics": 0,
      "Engineering Economy": 0,
      "Engineering Ethics and Professionalism": 0,
      "Engineering Mathematics": 0,
      "Engineering Mechanics": 0,
      "Engineering Materials": 0,
      "Facilities Planning and Design": 0,
      "Human Factors Engineering": 0,
      "Industrial Automation and Robotics": 0,
      "Industrial Engineering Fundamentals": 0,
      "Lean Manufacturing and Six Sigma": 0,
      "Manufacturing Processes": 0,
      "Operations Research": 0,
      "Probability and Statistics for Engineers": 0,
      "Production Planning and Control": 0,
      "Project Management": 0,
      "Quality Engineering and Management": 0,
      "Supply Chain Management": 0,
      "Sustainable Manufacturing": 0,
      "Work System Design and Ergonomics": 0,
      "subjects" : {
        "Engineering Drawing and Graphics": false,
        "Engineering Economy": false,
        "Engineering Ethics and Professionalism": false,
        "Engineering Mathematics": false,
        "Engineering Mechanics": false,
        "Engineering Materials": false,
        "Facilities Planning and Design": false,
        "Human Factors Engineering": false,
        "Industrial Automation and Robotics": false,
        "Industrial Engineering Fundamentals": false,
        "Lean Manufacturing and Six Sigma": false,
        "Manufacturing Processes": false,
        "Operations Research": false,
        "Probability and Statistics for Engineers": false,
        "Production Planning and Control": false,
        "Project Management": false,
        "Quality Engineering and Management": false,
        "Supply Chain Management": false,
        "Sustainable Manufacturing": false,
        "Work System Design and Ergonomics": false
      },
    "subs" : industrialengineering
    };
    users.add(dataToSave);
  }

  bioTechnology(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location":location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Basic Electrical Engineering": 0,
      "Basic Mechanical Engineering": 0,
      "Biochemistry": 0,
      "Biocomputing": 0,
      "Biomedical Engineering": 0,
      "Bioprocess Engineering": 0,
      "Biophysics": 0,
      "Bioreactors and Fermentation Technology": 0,
      "Biosensors and Bioinstrumentation": 0,
      "Bioethics and Intellectual Property Rights": 0,
      "Bioinformatics": 0,
      "Cell Biology": 0,
      "Engineering Chemistry": 0,
      "Engineering Graphics": 0,
      "Engineering Mathematics": 0,
      "Engineering Physics": 0,
      "Environmental Biotechnology": 0,
      "Food Biotechnology": 0,
      "Genetic Engineering": 0,
      "Genetics": 0,
      "Immunology": 0,
      "Industrial Biotechnology": 0,
      "Microbiology": 0,
      "Molecular Biology": 0,
      "Nanobiotechnology": 0,
      "Pharmaceutical Biotechnology": 0,
      "Plant and Animal Biotechnology": 0,
      "Biostatistics": 0,
      "Biotechnology Engineering": 0,
      "Bioproduction and Downstream Processing": 0,
      "subjects" : {
        "Basic Electrical Engineering": false,
        "Basic Mechanical Engineering": false,
        "Biochemistry": false,
        "Biocomputing": false,
        "Biomedical Engineering": false,
        "Bioprocess Engineering": false,
        "Biophysics": false,
        "Bioreactors and Fermentation Technology": false,
        "Biosensors and Bioinstrumentation": false,
        "Bioethics and Intellectual Property Rights": false,
        "Bioinformatics": false,
        "Cell Biology": false,
        "Engineering Chemistry": false,
        "Engineering Graphics": false,
        "Engineering Mathematics": false,
        "Engineering Physics": false,
        "Environmental Biotechnology": false,
        "Food Biotechnology": false,
        "Genetic Engineering": false,
        "Genetics": false,
        "Immunology": false,
        "Industrial Biotechnology": false,
        "Microbiology": false,
        "Molecular Biology": false,
        "Nanobiotechnology": false,
        "Pharmaceutical Biotechnology": false,
        "Plant and Animal Biotechnology": false,
        "Biostatistics": false,
        "Biotechnology Engineering": false,
        "Bioproduction and Downstream Processing": false
      },
    "subs" : bioTech
    };
    users.add(dataToSave);
  }

  automobile(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location":location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Automotive Business and Management": 0,
      "Automotive Chassis": 0,
      "Automotive Design and Manufacturing": 0,
      "Automotive Diagnostics and Troubleshooting": 0,
      "Automotive Electrical and Electronics Systems": 0,
      "Automotive Engines": 0,
      "Automotive Ergonomics and Human Factors Engineering": 0,
      "Automotive Fuel and Emission Control Systems": 0,
      "Automotive HVAC and Climate Control Systems": 0,
      "Automotive Maintenance and Servicing": 0,
      "Automotive Materials and Metallurgy": 0,
      "Automotive Quality Management": 0,
      "Automotive Regulations and Standards": 0,
      "Automotive Safety and Crashworthiness": 0,
      "Automotive Transmission Systems": 0,
      "Automotive Vehicle Dynamics": 0,
      "Engineering Graphics": 0,
      "Engineering Mechanics": 0,
      "Strength of Materials": 0,
      "Thermodynamics": 0,
      "Automotive Engineering Project": 0,
      "subjects" : {
        "Automotive Business and Management": false,
        "Automotive Chassis": false,
        "Automotive Design and Manufacturing": false,
        "Automotive Diagnostics and Troubleshooting": false,
        "Automotive Electrical and Electronics Systems": false,
        "Automotive Engines": false,
        "Automotive Ergonomics and Human Factors Engineering": false,
        "Automotive Fuel and Emission Control Systems": false,
        "Automotive HVAC and Climate Control Systems": false,
        "Automotive Maintenance and Servicing": false,
        "Automotive Materials and Metallurgy": false,
        "Automotive Quality Management": false,
        "Automotive Regulations and Standards": false,
        "Automotive Safety and Crashworthiness": false,
        "Automotive Transmission Systems": false,
        "Automotive Vehicle Dynamics": false,
        "Engineering Graphics": false,
        "Engineering Mechanics": false,
        "Strength of Materials": false,
        "Thermodynamics": false,
        "Automotive Engineering Project": false
      },
    "subs" : autoMobile
    };
    users.add(dataToSave);
  }

  aerospace(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location":location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Aerodynamics": 0,
      "Aerospace Design and Analysis": 0,
      "Aerospace Engineering Laboratory": 0,
      "Aerospace Materials and Manufacturing": 0,
      "Aerospace Structures and Materials": 0,
      "Aerospace Vehicle Dynamics and Control": 0,
      "Aircraft Performance and Operations": 0,
      "Aircraft Propulsion": 0,
      "Aircraft Stability and Control": 0,
      "Avionics and Instrumentation": 0,
      "Computational Fluid Dynamics": 0,
      "Engineering Mechanics": 0,
      "Flight Dynamics and Control": 0,
      "Introduction to Aerospace Engineering": 0,
      "Mathematics for Aerospace Engineers": 0,
      "Physics for Aerospace Engineers": 0,
      "Rocket Propulsion": 0,
      "Space Mechanics and Orbital Dynamics": 0,
      "Spacecraft Design and Operations": 0,
      "Spacecraft Propulsion Systems": 0,
      "Spacecraft Systems Engineering": 0,
      "subjects" : {
        "Aerodynamics": false,
        "Aerospace Design and Analysis": false,
        "Aerospace Engineering Laboratory": false,
        "Aerospace Materials and Manufacturing": false,
        "Aerospace Structures and Materials": false,
        "Aerospace Vehicle Dynamics and Control": false,
        "Aircraft Performance and Operations": false,
        "Aircraft Propulsion": false,
        "Aircraft Stability and Control": false,
        "Avionics and Instrumentation": false,
        "Computational Fluid Dynamics": false,
        "Engineering Mechanics": false,
        "Flight Dynamics and Control": false,
        "Introduction to Aerospace Engineering": false,
        "Mathematics for Aerospace Engineers": false,
        "Physics for Aerospace Engineers": false,
        "Rocket Propulsion": false,
        "Space Mechanics and Orbital Dynamics": false,
        "Spacecraft Design and Operations": false,
        "Spacecraft Propulsion Systems": false,
        "Spacecraft Systems Engineering": false
      },
    "subs" : aeroSpace
    };
    users.add(dataToSave);
  }

  chemical(){
    CollectionReference users = FirebaseFirestore.instance.collection("Andhra Pradesh");
    Map<String, dynamic> dataToSave =
    {"name": studentName,
      "admission_No": userName,
      "location":location,
      "email" : email,
      "college" : university,
      "year" : yearOfStudy,
      "Branch" : course,
      'profilePic' : profURL,
      "Chemical Process Calculations": 0,
      "Chemical Reaction Engineering": 0,
      "Chemical Thermodynamics": 0,
      "Chemical Engineering Laboratory": 0,
      "Chemical Engineering Principles": 0,
      "Chemical Engineering Thermodynamics": 0,
      "Chemical Process Industries": 0,
      "Chemical Process Technology": 0,
      "Chemical Process Control": 0,
      "Chemical Engineering Design": 0,
      "Fluid Mechanics and Heat Transfer": 0,
      "Heat Transfer Operations": 0,
      "Mass Transfer Operations": 0,
      "Process Dynamics and Control": 0,
      "Process Equipment Design": 0,
      "Process Modeling and Simulation": 0,
      "Process Safety and Hazards": 0,
      "Separation Processes": 0,
      "Transport Phenomena": 0,
      "subjects" : {
        "Chemical Process Calculations": false,
        "Chemical Reaction Engineering": false,
        "Chemical Thermodynamics": false,
        "Chemical Engineering Laboratory": false,
        "Chemical Engineering Principles": false,
        "Chemical Engineering Thermodynamics": false,
        "Chemical Process Industries": false,
        "Chemical Process Technology": false,
        "Chemical Process Control": false,
        "Chemical Engineering Design": false,
        "Fluid Mechanics and Heat Transfer": false,
        "Heat Transfer Operations": false,
        "Mass Transfer Operations": false,
        "Process Dynamics and Control": false,
        "Process Equipment Design": false,
        "Process Modeling and Simulation": false,
        "Process Safety and Hazards": false,
        "Separation Processes": false,
        "Transport Phenomena": false
      },
    "subs" : chemicals
    };
    users.add(dataToSave);
  }
}
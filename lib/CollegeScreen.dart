
import 'package:qa/Coordinates.dart';
import 'package:qa/EmailOTP.dart';
import 'package:qa/SignUp_Screen.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


String pressed = '';
String year = '';
String grad = '';
class CollegeScreen extends StatefulWidget {
  const CollegeScreen({Key? key}) : super(key: key);

  @override
  State<CollegeScreen> createState() => CollegeScreenState();
}

class CollegeScreenState extends State<CollegeScreen> with SingleTickerProviderStateMixin{
  final TextEditingController _collegeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DepartmentState departmentState = DepartmentState();
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          "Enter Your College Name",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Note: Please make sure that all the students in your College are Entering the Same College Name",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ReusableField(labelText: "Enter Your College Name",  
                icon: Icons.school_outlined,
                isPasswordType: false, formKey: _formKey,
                controller: _collegeController, animationController: _animationController)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          college = _collegeController.text;
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Department()),
            );
          }
        },
        backgroundColor: const Color(0xFF7045FF),
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}

class ProfData extends StatefulWidget {
  const ProfData({Key? key}) : super(key: key);

  @override
  State<ProfData> createState() => ProfDataState();
}

class ProfDataState extends State<ProfData> {
  final List<String> data = <String>["Attendance", "Generate QR"];
  final List<String> subtitle = <String>["View", "Generate QR"];
  EmailScreenState emailScreenState = EmailScreenState();

  @override
  void initState() {
    emailScreenState.getLoginData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          department,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (data[index] == "Attendance") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Year()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Coordinates()),
                );
              }
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  data[index] == "Attendance" ? Icons.calendar_today : Icons.qr_code,
                  color: Colors.black,
                ),
                title: Text(
                  data[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  subtitle[index],
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class Year extends StatefulWidget {
  const Year({Key? key}) : super(key: key);

  @override
  State<Year> createState() => _YearState();
}

class _YearState extends State<Year> with SingleTickerProviderStateMixin {
  List<String> data = ["1", "2", "3", "4"];
  late AnimationController _controller;
  late Animation<double> _animation;
  EmailScreenState emailScreenState = EmailScreenState();

  @override
  void initState() {
    super.initState();
    emailScreenState.getLoginData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          department,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              year = data[index];
              _controller.forward().then((_) => _controller.reverse());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Subjects()),
              );
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  data[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  year = data[index];
                  _controller.forward().then((_) => _controller.reverse());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Subjects()),
                  );
                },
                leading: ScaleTransition(
                  scale: _animation,
                  child: const Icon(
                    Ionicons.md_book,
                    color: Colors.purple,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



class Subjects extends StatefulWidget {

  const Subjects({super.key});

  @override
  State<Subjects> createState() => SubjectsState();
}

class SubjectsState extends State<Subjects> {
  EmailScreenState emailScreenState = EmailScreenState();
  DepartmentState departmentState = DepartmentState();

  @override
  void initState() {
    emailScreenState.getLoginData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(department,style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Subjects')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<String> dataList = [];
              DocumentSnapshot documentSnapshot = snapshot.data?.docs.first as DocumentSnapshot<Object?>;
              if(documentSnapshot.exists){
                List<dynamic> arrayData = documentSnapshot.get(department);
                List<String> myList = arrayData.map((item) => item.toString()).toList();
                dataList = myList;
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(dataList[index],style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        onTap: (){
                          year = year;
                          pressed = dataList[index];
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Attendance()));
                        },
                      ),
                    );
                  },
                );
              }else{
                return const Text("No document found");
              }
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(
                child: CircularProgressIndicator());
            }
          },
        )

    );
  }

}


class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => AttendanceState();
}

class AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          pressed,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Andhra Pradesh')
            .where("college", isEqualTo: college)
            .where("year", isEqualTo: year)
            .where("Branch", isEqualTo: department)
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                if (documentSnapshot.exists) {
                  final String profileImageUrl =
                  documentSnapshot['profilePic'];

                  Widget leadingWidget;
                  if (profileImageUrl.isNotEmpty) {
                    leadingWidget = CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(profileImageUrl),
                    );
                  } else {
                    leadingWidget = const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    );
                  }

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: leadingWidget,
                      title: Text(
                        "Roll Number: ${documentSnapshot['admission_No']}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "Attendance: ${documentSnapshot[pressed]}",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "No Data Found",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }
        },
      ),
    );
  }
}

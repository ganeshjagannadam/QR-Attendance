
import 'package:flutter/material.dart';
import 'Colors_utils.dart';



class SelectSubject extends StatefulWidget{
  const SelectSubject({super.key});

  @override
  selectSubject createState() => selectSubject();
}

dynamic valueChoose;
List listItems = ["java","Operating System","Computer Networks","Data Structures"];
class selectSubject extends State<SelectSubject>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "What Subjects do you Teach",
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
              children: <Widget>[
               SizedBox(
                 width: double.infinity,
                 height: MediaQuery.of(context).size.height *0.7,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children:  [
                    const Padding(padding: EdgeInsets.all(20),
                       child: Text("Select Subject",
                         style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16,color: Colors.blueGrey),),
                     ),
                     Container(
                       margin:  const EdgeInsets.symmetric(horizontal: 20),
                       decoration:  BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: Center(

                      ),
                     ),
                   ],
                 ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }


  add(){
    DropdownButton(
      hint: const Text("Select subjects"),
      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
      iconSize: 36,
      value: valueChoose,
      onChanged: (newValue)
      {
        setState(() {
          valueChoose = newValue;
        });
      },
      items: listItems.map((valueItem){
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem),
        );
      }
      ).toList(),
    );
  }

}
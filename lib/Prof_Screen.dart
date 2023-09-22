import 'package:flutter/material.dart';

class ProfHome extends StatefulWidget {
  const ProfHome({Key? key}) : super(key: key);

  @override
  _Profhome createState() => _Profhome();

}

class _Profhome extends State<ProfHome>{
  @override
  Widget build(BuildContext context) {
    return  Scaffold( extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title : const Center(
          child: Text("Generate a QR",selectionColor: Colors.black87,style: TextStyle(
              fontStyle: FontStyle.normal, fontWeight: FontWeight.w200,fontSize: 50),),
        ),
      ),
      body: const Center(
        child:  Text("Hello Professor", textAlign: TextAlign.center, style: TextStyle(
            fontStyle : FontStyle.normal, fontWeight: FontWeight.w200, fontSize: 20,
            color: Colors.black87)),
      ),);
  }
}
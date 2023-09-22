
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget{
  const Dropdown({super.key});

  @override
  Autofill createState() => Autofill();

}

class Autofill extends State<Dropdown>{
  bool isLoading = false;

  Future fetchAutoCompleteData() async
  {
      setState(() {
        isLoading = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Autocomplete")),

    );
  }
}
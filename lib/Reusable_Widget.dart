
import 'dart:convert';
import 'package:flutter/material.dart';

String secreteKey = "nqzrjmsvklptyhwbfxcdgnpqstrjhz";

Image logoWidget(String ImageName){
  return Image.asset(
    ImageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,);
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType, TextEditingController controller){
  return TextField(
    controller: controller,
    obscureText : isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(prefixIcon: Icon(icon, color: Colors.white70,),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(width: 50,
            style: BorderStyle.none))),
    keyboardType: isPasswordType? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}
Container SigninSignUpButton(BuildContext context , bool isLogin, Function onTap, {required Color textColor, required String buttonText}){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.pressed)){
              return Colors.white;
            }
            return const Color(0xFF7045FF);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))), child: Text(
      isLogin ? 'LOG IN' : 'SIGN UP',
      style: const TextStyle(
          color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 16
      ),
    ),
    ),
  );
}

Form reusableField({
  required String text,
  required IconData icon,
  required bool isPasswordType,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
}) {
  return Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: controller,
          obscureText: isPasswordType,
          autocorrect: !isPasswordType,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black.withOpacity(0.9)),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            labelText: text,
            labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          keyboardType: isPasswordType
              ? TextInputType.visiblePassword
              : TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ],
    ),
  );
}


class Security{


  String encryptString(String plainText) {
    final keyBytes = utf8.encode(secreteKey);
    final plainTextBytes = utf8.encode(plainText);

    for (var i = 0; i < plainTextBytes.length; i++) {
      plainTextBytes[i] ^= keyBytes[i % keyBytes.length];
    }

    final encryptedText = base64.encode(plainTextBytes);
    return encryptedText;
  }

  String decryptString(String encryptedText) {
    final keyBytes = utf8.encode(secreteKey);
    final encryptedBytes = base64.decode(encryptedText);

    for (var i = 0; i < encryptedBytes.length; i++) {
      encryptedBytes[i] ^= keyBytes[i % keyBytes.length];
    }

    final decryptedText = utf8.decode(encryptedBytes);
    return decryptedText;
  }
}
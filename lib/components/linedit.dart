import 'package:flutter/material.dart';



class LineEdit extends StatelessWidget {

  final TextEditingController  controller;
  final String hintText;
  final bool obscureText;
  Function(String)? onTextChanged;
  Function(String)? onSubmitted;
  final FocusNode? focusNode ;

  final inputType;
   LineEdit({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.inputType  =  TextInputType.text,
    this.onTextChanged,
     this.onSubmitted ,
     this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return  TextField(
      focusNode: focusNode,
      keyboardType: inputType,
      controller: controller,
      obscureText:obscureText,
      style: const TextStyle(color: Colors.white),
      decoration:  InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        hintText:  hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
      onChanged: onTextChanged,
      onSubmitted: onSubmitted,

    );
  }
}

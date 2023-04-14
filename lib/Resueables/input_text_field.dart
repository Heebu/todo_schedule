import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key, required this.hint, required this.isObscured, required this.icons, required this.textInputType, required this.controller,
  }) : super(key: key);
  final String hint;
  final bool isObscured;
  final Icon icons;
  final TextInputType textInputType;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(),
      ),
      margin: EdgeInsets.symmetric(vertical: 15),
      child:  Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
            controller: controller,
            obscureText: isObscured,
            keyboardType: textInputType,
            decoration: InputDecoration(
              border: InputBorder.none,

              hintText: hint,
              suffixIcon: icons,
            )),
      ),
    );
  }
}
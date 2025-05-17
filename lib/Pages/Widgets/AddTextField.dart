import 'package:flutter/material.dart';

class AddTextField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  TextInputType type;
  AddTextField(
      {required this.hint, required this.controller, required this.type});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      keyboardType: type,
    );
  }
}

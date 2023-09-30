import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const TextInputWidget(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: const TextStyle(color: Colors.white,),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

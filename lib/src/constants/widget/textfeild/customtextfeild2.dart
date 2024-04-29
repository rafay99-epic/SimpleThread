import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final int maxLines;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool enabled;
  final bool obsuretext;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.maxLines = 1,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.enabled = true,
    this.obsuretext = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        enabled: enabled,
        maxLines: maxLines,
        obscureText: obsuretext,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

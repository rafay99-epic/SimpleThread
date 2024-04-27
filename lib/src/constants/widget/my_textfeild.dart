import 'package:flutter/material.dart';

class MyTextFeild extends StatelessWidget {
  final String hintText;
  final bool obsuretext;
  final TextEditingController controller;
  final IconData? icons;
  final FocusNode? focusNode;
  final bool isNumeric;
  final bool isEnabled;
  const MyTextFeild({
    super.key,
    required this.hintText,
    required this.obsuretext,
    required this.controller,
    this.isEnabled = true,
    this.icons,
    this.focusNode,
    this.isNumeric = false,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obsuretext,
        controller: controller,
        enabled: isEnabled,
        focusNode: focusNode,
        keyboardType: isNumeric ? TextInputType.number : null,
        style: TextStyle(fontSize: screenHeight * 0.02),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          //filling information style
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          prefixIcon: Icon(
            icons,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

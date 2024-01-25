import 'package:flutter/material.dart';

class MyTextFeild extends StatelessWidget {
  final String hintText;
  final bool obsuretext;
  final TextEditingController controller;
  final IconData icons;
  final FocusNode? focusNode;
  const MyTextFeild({
    super.key,
    required this.hintText,
    required this.obsuretext,
    required this.controller,
    required this.icons,
    this.focusNode,
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
        focusNode: focusNode,
        style: TextStyle(fontSize: screenHeight * 0.02), // 2% of screen height
        decoration: InputDecoration(
            //this is the enable the Text Feild color and design
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            // Focus style
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
            )),
      ),
    );
  }
}

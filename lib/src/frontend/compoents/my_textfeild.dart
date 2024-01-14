import 'package:flutter/material.dart';

class MyTextFeild extends StatelessWidget {
  final String hintText;
  final bool obsuretext;
  final TextEditingController controller;
  final IconData icons;
  const MyTextFeild({
    super.key,
    required this.hintText,
    required this.obsuretext,
    required this.controller,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obsuretext,
        controller: controller,
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

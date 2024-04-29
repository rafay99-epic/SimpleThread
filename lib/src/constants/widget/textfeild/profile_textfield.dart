import 'package:flutter/material.dart';

Widget buildField(String fieldName, IconData icon,
    TextEditingController controller, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            fieldName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            controller.text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 22,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    ],
  );
}

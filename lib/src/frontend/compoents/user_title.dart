import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const SizedBox(
              width: 35,
            ),
            //icon
            const Icon(Icons.person_rounded),
            const SizedBox(
              width: 20,
            ),
            //username
            Text(text),
          ],
        ),
      ),
    );
  }
}

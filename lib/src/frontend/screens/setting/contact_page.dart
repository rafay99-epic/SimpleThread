// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:simplethread/src/backend/services/contactMessage/contactMessage.dart';
import 'package:simplethread/src/frontend/widget/customtextfeild2.dart';
import 'package:simplethread/src/frontend/widget/my_appbar.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  //controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  void sendMessage(BuildContext context) async {
    try {
      ContactService contactService = ContactService();

      await contactService.saveContactMessage(
        emailController.text,
        nameController.text,
        messageController.text,
        context,
      );

      messageController.clear();
      nameController.clear();
      emailController.clear();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Failed to send message: $e",
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: Text(
            e.toString(),
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  //build Main Function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Contact US"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Lottie.asset(
                  'assets/animation/login_message.json',
                  width: 150,
                  height: 150,
                ),
              ),
              Text(
                'Simple Thread',
                style: TextStyle(
                  letterSpacing: .5,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 35),
              CustomTextField(
                labelText: 'Name',
                controller: nameController,
                hintText: 'Enter your name',
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 35),
              CustomTextField(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icons.email,
                controller: emailController,
              ),
              const SizedBox(height: 35),
              CustomTextField(
                labelText: 'Message',
                controller: messageController,
                maxLines: 5,
                hintText: 'Enter your message',
                prefixIcon: Icons.message,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => sendMessage(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

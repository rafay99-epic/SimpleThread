import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:simplethread/src/frontend/compoents/my_appbar.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  Widget buildTextField(String labelText,
      {int maxLines = 1,
      required String hintText,
      required IconData prefixIcon,
      required TextEditingController controller}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        maxLines: maxLines,
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
              buildTextField(
                'Name',
                controller: nameController,
                hintText: 'Enter your name',
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 35),
              buildTextField(
                'Email',
                hintText: 'Enter your email',
                prefixIcon: Icons.email,
                controller: emailController,
              ),
              const SizedBox(height: 35),
              buildTextField(
                'Message',
                controller: messageController,
                maxLines: 5,
                hintText: 'Enter your message',
                prefixIcon: Icons.message,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final email = emailController.text;
                  final message = messageController.text;

                  // Create the mailto link
                  final mailtoLink = Uri(
                    scheme: 'mailto',
                    path: '99marafay@gmail.com',
                    queryParameters: {
                      'subject': 'Contact form from $name',
                      'body': 'Name: $name\nEmail: $email\nMessage: $message',
                    },
                  ).toString();

                  // Open the link
                  launch(mailtoLink);
                },
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

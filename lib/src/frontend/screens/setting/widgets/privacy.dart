import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplethread/src/constants/widget/my_appbar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Privacy Policy',
        backbutton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'This Privacy Policy governs the manner in which Simple Thread collects, uses, maintains, and discloses information collected from users ("User") of the Simple Thread application ("App").',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              textAlign: TextAlign.justify,
              'Personal Identification Information',
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'We may collect personal identification information from Users in various ways, including but not limited to, when Users visit our App, register on the App, place an order, subscribe to the newsletter, respond to a survey, fill out a form, and in connection with other activities, services, features, or resources we make available on our App. Users may be asked for, as appropriate, name, email address, phone number. Users may, however, visit our App anonymously. We will collect personal identification information from Users only if they voluntarily submit such information to us. Users can always refuse to supply personally identification information, except that it may prevent them from engaging in certain App-related activities.',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              textAlign: TextAlign.justify,
              'Non-personal Identification Information',
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'We may collect non-personal identification information about Users whenever they interact with our App. Non-personal identification information may include the browser name, the type of device, and technical information about Users\' means of connection to our App, such as the operating system and the Internet service providers utilized and other similar information.',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              textAlign: TextAlign.justify,
              'How We Use Collected Information',
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'Simple Thread may collect and use Users\' personal information for the following purposes: - To improve customer service: Information you provide helps us respond to your customer service requests and support needs more efficiently. - To personalize user experience: We may use information in the aggregate to understand how our Users as a group use the services and resources provided on our App. - To improve our App: We may use feedback you provide to improve our products and services. - To send periodic emails: We may use the email address to respond to their inquiries, questions, and/or other requests. If User decides to opt-in to our mailing list, they will receive emails that may include company news, updates, related product or service information, etc. If at any time the User would like to unsubscribe from receiving future emails, we include detailed unsubscribe instructions at the bottom of each email.',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              textAlign: TextAlign.justify,
              'How We Protect Your Information',
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'We adopt appropriate data collection, storage, and processing practices and security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal information, username, password, transaction information, and data stored on our App.',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              textAlign: TextAlign.justify,
              'Sharing Your Personal Information',
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'We do not sell, trade, or rent Users\' personal identification information to others. We may share generic aggregated demographic information not linked to any personal identification information regarding visitors and users with our business partners, trusted affiliates, and advertisers for the purposes outlined above.',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              textAlign: TextAlign.justify,
              'Changes to This Privacy Policy',
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'Simple Thread has the discretion to update this privacy policy at any time. When we do, we will revise the updated date at the bottom of this page. We encourage Users to frequently check this page for any changes to stay informed about how we are helping to protect the personal information we collect. You acknowledge and agree that it is your responsibility to review this privacy policy periodically and become aware of modifications.',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              textAlign: TextAlign.justify,
              'Your Acceptance of These Terms',
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'By using this App, you signify your acceptance of this policy. If you do not agree to this policy, please do not use our App. Your continued use of the App following the posting of changes to this policy will be deemed your acceptance of those changes.',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              textAlign: TextAlign.justify,
              'Contacting Us',
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'If you have any questions about this Privacy Policy, the practices of this App, or your dealings with this App, please contact us at [Your contact information].',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              textAlign: TextAlign.justify,
              'This document was last updated on 23rd March 2024',
              style: GoogleFonts.roboto(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

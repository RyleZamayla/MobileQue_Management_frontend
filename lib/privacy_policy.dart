import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05046a),
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to our app! We respect your privacy and are committed to protecting your personal information.',
              ),
              SizedBox(height: 16),
              Text(
                '1. Information Collection',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We collect information you provide when you use OurApp, such as your name and email address.',
              ),
              SizedBox(height: 16),
              Text(
                '2. Information Usage',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We use the collected information to provide and improve OurApp services. We may also use the information to contact you with newsletters, marketing, or promotional materials.',
              ),
              SizedBox(height: 16),
              Text(
                '3. Information Sharing',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We do not sell, trade, or rent your personal information to third parties. We may share information with trusted service providers who assist us in operating our application.',
              ),
              SizedBox(height: 16),
              Text(
                '4. Data Security',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We implement security measures to protect your information. However, please note that no method of transmission over the internet or electronic storage is 100% secure.',
              ),
              SizedBox(height: 16),
              Text(
                '5. Your Choices',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'You may opt-out of receiving marketing communications from us. You can also request to access, update, or delete your personal information by contacting us.',
              ),
              // Add more content here if needed
            ],
          ),
        ),
      ),
    );
  }
}

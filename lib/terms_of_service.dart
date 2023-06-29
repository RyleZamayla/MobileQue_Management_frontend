import 'package:flutter/material.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05046a),
        title: const Text('Terms of Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Terms of Service',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to our app! Please read these terms of service carefully before using our application.',
              ),
              SizedBox(height: 16),
              Text(
                '1. Acceptance of Terms',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'By using our app, you agree to be bound by these terms of service. If you do not agree to these terms, please do not use the application.',
              ),
              SizedBox(height: 16),
              Text(
                '2. Use of the Application',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'You may use our app for personal, non-commercial purposes only. You may not use the application in any way that violates applicable laws or regulations.',
              ),
              SizedBox(height: 16),
              Text(
                '3. Intellectual Property',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Our app and its content are protected by intellectual property laws. You may not copy, modify, distribute, or reproduce any part of the application without prior written consent.',
              ),
              SizedBox(height: 16),
              Text(
                '4. Disclaimer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Our app is provided "as is" without any warranties or guarantees. We do not guarantee the accuracy, reliability, or suitability of the application for any purpose.',
              ),
              SizedBox(height: 16),
              Text(
                '5. Limitation of Liability',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We shall not be liable for any damages arising out of the use or inability to use our app. You use the application at your own risk.',
              ),
              // Add more content here if needed
            ],
          ),
        ),
      ),
    );
  }
}

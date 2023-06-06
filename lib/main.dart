import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/screens/auth/student_login.dart';

void main() {
  runApp(const QueManagement());
}

class QueManagement extends StatelessWidget {
  const QueManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorDark: const Color(0xFF05046a),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }

}

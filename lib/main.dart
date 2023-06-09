import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/screens/feed.dart';

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
      home: const MyHomePage(title:"Instructors"),
      debugShowCheckedModeBanner: false,
    );
  }

}

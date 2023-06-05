import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/bottom_nav_bar.dart';
import 'package:mobilequemanagement_frontend/drawer.dart';
import 'package:mobilequemanagement_frontend/student_login.dart';
import 'package:mobilequemanagement_frontend/qr_button.dart';

void main() {
  runApp(const FeedApp());
}

class FeedApp extends StatelessWidget {
  const FeedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF05046a),
        primaryColorDark: const Color(0xFF05046a),
        visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF05046a)),
      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: const <Widget>[
          // This can be iterable via loop and using models, for UI purposes only
          InstructorCard(
            name: 'Jay Noel Rojo',
            position: 'Department Chairman',
            available: true,
          ),
          InstructorCard(
            name: 'Jomar C. Llevado',
            position: 'IT Faculty',
            available: false,
          ),
          InstructorCard(
            name: 'Arlene Baldelovar',
            position: 'IT Faculty',
            available: true,
          ),
          // Add more InstructorCard widgets for other instructors
        ],
      ),
      floatingActionButton: const ActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class InstructorCard extends StatelessWidget {
  const InstructorCard({
    Key? key,
    required this.name,
    required this.position,
    required this.available,
  }) : super(key: key);

  final String name;
  final String position;
  final bool available;

  @override
  Widget build(BuildContext context) {
    Color availabilityColor = available ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(name),
        subtitle: Text(position),
        trailing: CircleAvatar(
          backgroundColor: availabilityColor,
          radius: 8.0,
        ),
      ),
    );
  }
}

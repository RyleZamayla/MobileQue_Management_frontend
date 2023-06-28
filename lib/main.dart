import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/screens/admin_dashboard.dart';
import 'package:mobilequemanagement_frontend/screens/feed.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('userId');
  runApp(MaterialApp(
    title: 'Mobile Queueing Management',
    theme: ThemeData(
      primaryColor: Colors.white,
      primaryColorDark: const Color(0xFF05046a),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
    ),
    home: userId == null ? const MyHomePage(title: "Dashboard"): adminDashboard(),
    debugShowCheckedModeBanner: false,
  )
  );
}


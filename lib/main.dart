import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/screens/admin_dashboard.dart';
import 'package:mobilequemanagement_frontend/screens/feed.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes.dart';
import 'screens/current_queue.dart';
import 'screens/materials/settings.dart';
import 'screens/queue_history.dart';

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
    home: userId == null ? const MyHomePage(title: "Dashboard"): const adminDashboard(),
    debugShowCheckedModeBanner: false,
    routes: {

      Routes.currentQueue: (context) => currentQueue(),
      Routes.adminDashboard: (context) => const adminDashboard(),
      Routes.queueHistory: (context) => const queueHistory(),
      Routes.settings: (context) => const SettingsPage(),

    },
  ),
  );
}

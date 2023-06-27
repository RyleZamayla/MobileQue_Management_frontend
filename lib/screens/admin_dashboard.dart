import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/screens/current_queue.dart';
import 'package:mobilequemanagement_frontend/screens/feed.dart';
import 'package:mobilequemanagement_frontend/screens/queue_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'materials/settings.dart';

class adminDashboard extends StatefulWidget {
  adminDashboard({Key? key, this.futureAdmin}) : super(key: key);

  Map<String, dynamic>? futureAdmin;

  @override
  State<adminDashboard> createState() => _adminDashboardState();
}

class _adminDashboardState extends State<adminDashboard> {
  late Map<String, dynamic> admin;
  int _currentIndex = 0;

  final List<Widget> _tabs = [currentQueue(), const queueHistory()];

  void onTabTapped(int index) {
    // When a tab is tapped, change the state of the current index to the index of the selected tab
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    admin = widget.futureAdmin!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05046a),
        title: const Text("Admin Dashboard"),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF05046a),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF05046a), // Set the color of the header section
                ),
                accountName: Text(
                  "${admin['user']['name']}",
                  style: const TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  "${admin['user']['email']}",
                  style: const TextStyle(color: Colors.white),
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/background_student.jpg"),
                ),
              ),
              ListTile(
                tileColor: Colors.transparent,
                // Set the tile color to transparent
                leading: const Icon(Icons.queue, color: Colors.white),
                title: const Text('Current Queue', style: TextStyle(color: Colors.white)),
                onTap: () {
                  onTabTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                tileColor: Colors.transparent,
                // Set the tile color to transparent
                leading: const Icon(Icons.history, color: Colors.white),
                title: const Text('Queue History', style: TextStyle(color: Colors.white)),
                onTap: () {
                  onTabTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                tileColor: Colors.transparent,
                // Set the tile color to transparent
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text('Settings', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
              ),
              ListTile(
                tileColor: Colors.transparent,
                // Set the tile color to transparent
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('token');
                  prefs.remove('userId');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext ctx) => MyHomePage(title: "Dashboard",)));
                },
              ),
            ],
          ),
        ),
      ),
      body: _tabs[_currentIndex],
    );
  }
}

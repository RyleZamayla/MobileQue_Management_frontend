import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/provider/api_provider.dart';
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
  apiProvider api = apiProvider();
  late String? accessToken, name, email, position, queueLimit, userId,profilePic;

  final List<Widget> _tabs = [currentQueue(), const queueHistory()];

  void onTabTapped(int index) {
    // When a tab is tapped, change the state of the current index to the index of the selected tab
    setState(() {
      _currentIndex = index;
    });
  }

  fetchID()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('token');
    name = prefs.getString('name');
    email = prefs.getString('email');
    position = prefs.getString('position');
    queueLimit = prefs.getString('queueLimit');
    userId = prefs.getString('userId');
    profilePic = prefs.getString('profilePic');
    print("gawas build $name");
  }

  @override
  void initState(){
    admin = widget.futureAdmin ?? {'error':'error'};
    fetchID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(admin);
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
                  "${admin['error'] != 'error' ? admin['user']['name'] : name}",
                  style: const TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  "${admin ['error'] != 'error' ? admin['user']['email'] : email}",
                  style: const TextStyle(color: Colors.white),
                ),
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(25), // Half of the width or height for a perfect circle
                  child: Image(
                    image: NetworkImage(admin ['error'] != 'error' ? admin['user']['profilePic'] : profilePic??'https://scontent.fdvo5-1.fna.fbcdn.net/v/t39.30808-6/324429893_692617042404789_8825582010059206302_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEuGGRS4j1TRnpWy-X7IciFiSnhuT21QT-JKeG5PbVBP8vei6WwmkTDRRj7Yshbp_oOgXKi9I5yuhVxBQGTA9ct&_nc_ohc=cR43Oe7orLkAX8oqv9e&_nc_ht=scontent.fdvo5-1.fna&oh=00_AfBVoA5lCXiUjLB0d8bKiG7RALtAeq036ggnmpmJJW1XTw&oe=649E83B4'), // Replace with your image URL
                    width: 40, // Replace with desired image width
                    height: 40, // Replace with desired image height
                  ),
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
                  prefs.remove('name');
                  prefs.remove('email');
                  prefs.remove('position');
                  prefs.remove('queueLimit');
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

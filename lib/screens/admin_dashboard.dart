import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/screens/current_queue.dart';
import 'package:mobilequemanagement_frontend/screens/feed.dart';
import 'package:mobilequemanagement_frontend/screens/queue_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: const Text("Admin Dashboard"),
      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("${admin['user']['name']}"),
                accountEmail: Text("${admin['user']['email']}"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/background_student.jpg"),
                ),
              ),
              ListTile(
                leading: Icon(Icons.queue),
                title: Text('Current Queue'),
                onTap: () {
                  onTabTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Queue History'),
                onTap: () {
                  onTabTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Do something when the user taps on this ListTile
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('myMap');
                  prefs.remove('userId');
                  prefs.remove('accessToken');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext ctx) => MyHomePage(title: "Dashboard",)));
                },
              ),
            ],
          ),
      ),
      body: _tabs[_currentIndex],
    );
  }
}

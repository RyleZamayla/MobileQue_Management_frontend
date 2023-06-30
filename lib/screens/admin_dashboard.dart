import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/provider/api_provider.dart';
import 'package:mobilequemanagement_frontend/screens/current_queue.dart';
import 'package:mobilequemanagement_frontend/screens/feed.dart';
import 'package:mobilequemanagement_frontend/screens/queue_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'materials/settings.dart';

class adminDashboard extends StatefulWidget {
  const adminDashboard({Key? key}) : super(key: key);


  @override
  State<adminDashboard> createState() => _adminDashboardState();
}

class _adminDashboardState extends State<adminDashboard> {
  late Future<dynamic> admin;
  int _currentIndex = 0;
  apiProvider api = apiProvider();
  var formKey = GlobalKey<FormState>();
  TextEditingController queueNew = TextEditingController();
  String test = "Available";

  // Define a list of titles for each tab
  final List<String> _tabTitles = ['Current Queue', 'Queue History'];

  final List<Widget> _tabs = [currentQueue(), const queueHistory()];

  void onTabTapped(int index) {
    // When a tab is tapped, change the state of the current index to the index of the selected tab
    setState(() {
      _currentIndex = index;
    });
  }

  fetchUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return api.getAdminUser("user/", prefs.getString('userId'));
  }

  @override
  void initState(){
    admin = fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Disable the back button press
          return false;
        },
    child: Scaffold(
      body: FutureBuilder(
        future: admin,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else {
            // final data = snapshot.data as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF05046a),
                title: Text(_tabTitles[_currentIndex]),
                actions: [
                  DropdownButton(
                    dropdownColor: const Color(0xFF05046a),
                    value: test,
                    items: const [
                      DropdownMenuItem(
                        child: Text('Available',style: TextStyle(color: Colors.white)),
                        value: 'Available',
                      ),
                      DropdownMenuItem(
                        child: Text('Not Available',style: TextStyle(color: Colors.white)),
                        value: 'Not Available',
                      ),
                    ],
                    onChanged: (String? value) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Are you sure you want to change status?'),
                            actions: [
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: ()async{
                                  setState(() {
                                    test = value!;
                                  });
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  var response = await api.postAdminStatus('user/status', prefs.getString('token'), value);
                                  if(response != 'Failed to update status'){
                                    setState(() {
                                      snapshot.data.status = response['status'];
                                      // prefs.setString('status', response['status']);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Successfully updated status'),
                                        ),
                                      );
                                    });
                                  }else{
                                    setState(() {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Failed to update status'),
                                        ),
                                      );
                                    });
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  setState(() {
                                    test = test;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
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
                          "${snapshot.data.name}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        accountEmail: Text(
                          "${snapshot.data.email}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        currentAccountPicture: ClipRRect(
                          borderRadius: BorderRadius.circular(25), // Half of the width or height for a perfect circle
                          child: Image(
                            image: NetworkImage(snapshot.data.profilePic ?? 'https://scontent.fdvo5-1.fna.fbcdn.net/v/t39.30808-6/324429893_692617042404789_8825582010059206302_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEuGGRS4j1TRnpWy-X7IciFiSnhuT21QT-JKeG5PbVBP8vei6WwmkTDRRj7Yshbp_oOgXKi9I5yuhVxBQGTA9ct&_nc_ohc=cR43Oe7orLkAX8oqv9e&_nc_ht=scontent.fdvo5-1.fna&oh=00_AfBVoA5lCXiUjLB0d8bKiG7RALtAeq036ggnmpmJJW1XTw&oe=649E83B4'), // Replace with your image URL
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
                        leading: const Icon(Icons.change_circle, color: Colors.white),
                        title: const Text('Set Queue Limit', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          // userID.text = admin ['error'] != 'error' ? admin['user']['_id'] : userId;
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return Center(
                                  child: SingleChildScrollView(
                                    reverse: true,
                                    child: AlertDialog(
                                        title: const Center(child: Text('Set Queue Limit')),
                                        content: Form(
                                            key: formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("Current Queue Limit: ${snapshot.data.queueLimit}"),
                                                const SizedBox(height: 10),
                                                TextFormField(
                                                  controller: queueNew,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          width: 3,
                                                          color: Colors.yellowAccent),
                                                      borderRadius:
                                                      BorderRadius.circular(50.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      // Set focused border color
                                                      borderSide: const BorderSide(
                                                          width: 3,
                                                          color: Colors.yellowAccent),
                                                      borderRadius:
                                                      BorderRadius.circular(50.0),
                                                    ),
                                                    labelText: 'Queue Limit',
                                                    labelStyle:
                                                    const TextStyle(color: Colors.black),
                                                  ),
                                                  validator: (value) {
                                                    if (value == '' || value == null){
                                                      return 'Please enter Queue Limit';
                                                    }else if (value.contains(RegExp(r'[\W_]'))) {
                                                      return 'Special characters are not allowed';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ],
                                            )),
                                        actions: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  onPressed: ()async{
                                                    if(formKey.currentState!.validate()){
                                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                      var response = await api.postQueueLimit('user/limit', prefs.getString('token'),snapshot.data.id, queueNew.text);
                                                      if(response != "Failed to update queue limit"){
                                                        setState(() {
                                                          queueNew.clear();
                                                          snapshot.data.queueLimit = response['queueLimit'];
                                                          // prefs.setString('queueLimit', response['queueLimit'].toString());
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            const SnackBar(
                                                              content: Text('Successfully updated queue limit'),
                                                            ),
                                                          );
                                                          Navigator.of(context).pop();
                                                        });
                                                      }else{
                                                        setState(() {
                                                          queueNew.clear();
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            const SnackBar(
                                                              content: Text('Failed to update queue limit'),
                                                            ),
                                                          );
                                                        });
                                                      }
                                                    }
                                                  },
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(20.0),
                                                      ),
                                                    ),
                                                    foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                    backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(0xFF05046a)),
                                                    minimumSize:
                                                    MaterialStateProperty.all(
                                                        const Size(100.0,
                                                            48.0)),
                                                  ),
                                                  child: const Text(
                                                    'Update',
                                                    style: TextStyle(
                                                        fontSize:
                                                        18.0), // Adjust font size
                                                  ),
                                                ),
                                                const SizedBox(width: 20.0),
                                                // Add spacing between buttons
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      queueNew.clear();
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(20.0),
                                                      ),
                                                    ),
                                                    foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                    backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(0xFF05046a)),
                                                    minimumSize:
                                                    MaterialStateProperty.all(
                                                        const Size(100.0,
                                                            48.0)), // Adjust width
                                                  ),
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontSize:
                                                        18.0), // Adjust font size
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                  ),
                                );
                              }
                          );
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
                          // prefs.remove('name');
                          // prefs.remove('email');
                          // prefs.remove('position');
                          // prefs.remove('queueLimit');
                          // prefs.remove('status');
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (BuildContext ctx) => const MyHomePage(title: "Dashboard",)));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              body: _tabs[_currentIndex],
            );
          }
        },
      ),
    ),
    );
  }
}
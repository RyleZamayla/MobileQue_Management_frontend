import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/provider/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../routes.dart';

class currentQueue extends StatefulWidget {
  currentQueue({this.userId,Key? key}) : super(key: key);
  String? userId;

  @override
  State<currentQueue> createState() => _currentQueueState();
}

class _currentQueueState extends State<currentQueue> {
  late Future<dynamic> futureQueues;
  bool isGuest = true;
  apiProvider api = apiProvider();

  // void closeAllDialogs() {
  //   Navigator.of(context).popUntil((route) => route.settings.name == Routes.currentQueue);
  // }

  updateQueue(String queueId)async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return api.putQueue('queue/', queueId);
  }

  buildStudentInfo(AsyncSnapshot snapshot, int index) {
    return Center(
      child: SingleChildScrollView(
        reverse: true,
        child: AlertDialog(
          title: const Center(
              child: Text(
            'Information',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Student Number: ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].idNumber}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    "Student Name:",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    "Student Email:",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].email}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    "Purpose:",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].purpose}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      var response = updateQueue(snapshot.data![index].id);
                      if(response != "Error updating queue"){
                        setState((){
                          futureQueues = fetchID();
                          Navigator.of(context).pop();
                        });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error updating queue'),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF05046a)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(120.0, 48.0)),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Center(
                              child: Text(
                                'Notification Sent!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            actions: [
                              Center(
                                child: Container(
                                  width: 120.0,
                                  height: 48.0,
                                  child: TextButton(
                                    onPressed: () {
                                      // closeAllDialogs(); // Close all dialogs
                                      Navigator.pop(context);
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
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Okay',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF05046a)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(120.0, 48.0)),
                    ),
                    child: const Text(
                      'Notify',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  buildGuestInfo(AsyncSnapshot snapshot, int index) {
    return Center(
      child: SingleChildScrollView(
        reverse: true,
        child: AlertDialog(
          title: const Center(
              child: Text(
            'Information',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Guest Name:",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    "Guest Email:",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].email}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    "Purpose:",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].purpose}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    "Status:",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].status}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      var response = updateQueue(snapshot.data![index].id);
                      if(response != "Error updating queue"){
                        setState((){
                          futureQueues = fetchID();
                          Navigator.of(context).pop();
                        });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error updating queue'),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF05046a)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(120.0, 48.0)),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Center(
                              child: Text(
                                'Notification Sent!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            actions: [
                              Center(
                                child: Container(
                                  width: 120.0,
                                  height: 48.0,
                                  child: TextButton(
                                    onPressed: () {
                                      // closeAllDialogs(); // Close all dialogs
                                      Navigator.pop(context);

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
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Okay',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF05046a)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(120.0, 48.0)),
                    ),
                    child: const Text(
                      'Notify',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  fetchID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return api.postQueues("queue/pending", prefs.getString('userId'));
  }

  @override
  void initState() {
    futureQueues = fetchID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: futureQueues,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Display an error message if an error occurred
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                child: ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      'Q#${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    snapshot.data![index].purpose,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        if (snapshot.data![index].idNumber != null) {
                          isGuest = false;
                        } else {
                          isGuest = true;
                        }
                        return isGuest
                            ? buildGuestInfo(snapshot, index)
                            : buildStudentInfo(snapshot, index);
                      },
                    );
                  },
                  subtitle: Text(snapshot.data![index].name),
                  trailing: Text("Status: ${snapshot.data![index].status}",style: const TextStyle(color: Colors.red),),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}



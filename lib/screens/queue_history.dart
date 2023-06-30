import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobilequemanagement_frontend/provider/api_provider.dart';

class queueHistory extends StatefulWidget {
  const queueHistory({Key? key}) : super(key: key);

  @override
  State<queueHistory> createState() => _queueHistoryState();
}

class _queueHistoryState extends State<queueHistory> {
  late Future<dynamic> doneQueues;
  apiProvider api = apiProvider();
  bool isGuest = true;


  fetchDoneQueues()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        doneQueues = api.getDoneQueues("queue/done", prefs.getString('token'));
      });
    });
  }

  deleteQueue(String queueId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return api.deleteQueue('queue/delete', prefs.getString('token'), queueId);
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
                  const Text(
                    "Student Number:",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].idNumber}',
                      style: const TextStyle(
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
                  const Text(
                    "Student Number:",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].email}',
                      style: const TextStyle(
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
                  const Text(
                    "Purpose:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].purpose}',
                      style: const TextStyle(
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
            Center(
              child: TextButton(
                onPressed: () {
                  var response = deleteQueue(snapshot.data![index].id);
                  if (response != "Error deleting queue") {
                    setState(() {
                      doneQueues = fetchDoneQueues();
                      Navigator.of(context).pop();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error deleting queue'),
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
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  minimumSize:
                      MaterialStateProperty.all(const Size(120.0, 48.0)),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
                  const Text(
                    "Guest Name:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].name}',
                      style: const TextStyle(
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
                  const Text(
                    "Guest Email:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].email}',
                      style: const TextStyle(
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
                  const Text(
                    "Purpose:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].purpose}',
                      style: const TextStyle(
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
                  const Text(
                    "status:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${snapshot.data![index].status}',
                      style: const TextStyle(
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
            Center(
              child: TextButton(
                onPressed: () {
                  var response = deleteQueue(snapshot.data![index].id);
                  if (response != "Error deleting queue") {
                    setState(() {
                      doneQueues = fetchDoneQueues();
                      Navigator.of(context).pop();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error deleting queue'),
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
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  minimumSize:
                  MaterialStateProperty.all(const Size(120.0, 48.0)),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),            ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    doneQueues = fetchDoneQueues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: doneQueues,
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
                  subtitle: Text("${snapshot.data![index].name}"),
                  trailing: Text(
                    "Status: ${snapshot.data![index].status}",
                    style: const TextStyle(color: Colors.green),
                  ),
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

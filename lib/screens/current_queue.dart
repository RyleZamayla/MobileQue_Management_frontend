import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/provider/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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


  buildStudentInfo(AsyncSnapshot snapshot, int index){
    return Center(
      child: SingleChildScrollView(
        reverse: true,
        child: AlertDialog(
          title: const Center(child: Text('Information')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Student Number: ${snapshot.data![index].idNumber}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Student Name: ${snapshot.data![index].name}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Student Email: ${snapshot.data![index].email}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Purpose: ${snapshot.data![index].purpose}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Notify'),
            ),
            TextButton(
              onPressed: () {
                var response = deleteQueue(snapshot.data![index].id);
                if(response != "Error deleting queue"){
                  setState((){
                    futureQueues = fetchID();
                    Navigator.of(context).pop();
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error deleting queue'),
                    ),
                  );
                }
              },
              child: const Text('Delete',style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  buildGuestInfo(AsyncSnapshot snapshot, int index){
    return Center(
      child: SingleChildScrollView(
        reverse: true,
        child: AlertDialog(
          title: const Center(child: Text('Information')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Guest Name: ${snapshot.data![index].name}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Guest Email: ${snapshot.data![index].email}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Purpose: ${snapshot.data![index].purpose}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "status: ${snapshot.data![index].status}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Notify'),
            ),
            TextButton(
              onPressed: () {
                var response = deleteQueue(snapshot.data![index].id);
                if(response != "Error deleting queue"){
                  setState((){
                    futureQueues = fetchID();
                    Navigator.of(context).pop();
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error deleting queue'),
                    ),
                  );
                }
              },
              child: const Text('Delete',style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  deleteQueue(String queueId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return api.deleteQueue('queue/delete', prefs.getString('token'), queueId);
  }

  fetchID()async{
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
        } else if (snapshot.hasData){
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
                        if (snapshot.data![index].idNumber != null){
                          isGuest = false;
                        }else{
                          isGuest = true;
                        }
                        return isGuest ? buildGuestInfo(snapshot, index) : buildStudentInfo(snapshot, index);
                      },
                    );
                  },
                  subtitle: Text(snapshot.data![index].name),
                ),
              );
            },
          );
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}



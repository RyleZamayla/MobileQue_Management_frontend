import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/provider/api_provider.dart';

class currentQueue extends StatefulWidget {
  const currentQueue({Key? key}) : super(key: key);

  @override
  State<currentQueue> createState() => _currentQueueState();
}

class _currentQueueState extends State<currentQueue> {
  late Future<dynamic> futureQueues;
  apiProvider api = apiProvider();
  
  @override
  void initState() {
    futureQueues = api.getQueues("queue/pending");
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
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    snapshot.data![index].purpose,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Handle tile tap event
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



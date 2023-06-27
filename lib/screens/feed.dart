import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/provider/api_provider.dart';
import 'package:mobilequemanagement_frontend/screens/qr_scanner.dart';
import 'auth/login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<dynamic> futureUsers;
  var formKey = GlobalKey<FormState>();
  apiProvider api = apiProvider();

  @override
  void initState() {
    futureUsers = api.getUsers("user/");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05046a),
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QrScanner()));
            },
            icon: const Icon(Icons.qr_code_scanner_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            icon: const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 0),
          )
        ],
      ),
      // drawer: const CustomDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_student.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // Set the number of columns in the grid
                  mainAxisSpacing: 8.0,
                  // Add vertical spacing between the cards
                  crossAxisSpacing: 8.0,
                  // Add horizontal spacing between the cards
                  childAspectRatio:
                      0.75, // Adjust the aspect ratio to fit the content
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Center(child: Text('Add Queue')),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
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
                                      labelText: 'Student ID',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
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
                                      labelText: 'Student Name',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
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
                                      labelText: 'Student Email',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
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
                                      labelText: 'Purpose',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
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
                                                    48.0)),
                                        ),
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              fontSize:
                                                  18.0), // Adjust font size
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      // Add spacing between buttons
                                      TextButton(
                                        onPressed: () {
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
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize:
                                                  18.0), // Adjust font size
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]);
                        },
                      );
                    },
                    child: Opacity(
                      opacity: 0.85,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              snapshot.data![index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              snapshot.data![index].position,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "${snapshot.data![index].status ?? "Not Available"}",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

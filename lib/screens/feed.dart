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
  TextEditingController idNumber = TextEditingController();
  TextEditingController userId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController purpose = TextEditingController();
  late Future<dynamic> futureUsers;
  var formKey = GlobalKey<FormState>();
  apiProvider api = apiProvider();

  @override
  void initState() {
    futureUsers = api.getUsers("queue/count");
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
                      print(snapshot.data![index].id);
                      userId.text = snapshot.data![index].id;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: SingleChildScrollView(
                              reverse: true,
                              child: AlertDialog(
                                  title: const Center(child: Text('Add Queue')),
                                  content: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: idNumber,
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
                                              labelText: 'Student ID',
                                              labelStyle:
                                              TextStyle(color: Colors.black),
                                            ),
                                            validator: (value) {
                                              return (value == '') ? 'Please enter your ID number' : null;
                                            },
                                          ),
                                          const SizedBox(height: 16.0),
                                          TextFormField(
                                            controller: name,
                                            keyboardType: TextInputType.name,
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
                                            validator: (value) {
                                              return (value == '') ? 'Please enter your name' : null;
                                            },
                                          ),
                                          const SizedBox(height: 16.0),
                                          TextFormField(
                                            controller: email,
                                            keyboardType: TextInputType.emailAddress,
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
                                            validator: (val) {
                                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                                return "Enter a valid email address";
                                              }
                                            },
                                          ),
                                          const SizedBox(height: 16.0),
                                          TextFormField(
                                            controller: purpose,
                                            keyboardType: TextInputType.multiline,
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
                                            validator: (value) {
                                              return (value == '') ? 'Please enter your purpose' : null;
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
                                                Map<String,dynamic> userInfoMap = {
                                                  "userId": userId.text,
                                                  "email": email.text,
                                                  "name": name.text,
                                                  "purpose": purpose.text,
                                                  "idNumber": idNumber.text
                                                };
                                                var response = await api.postLogin(userInfoMap, "queue/");
                                                if(response != "Failed to add queue"){
                                                  setState(() {
                                                    userId.clear();
                                                    email.clear();
                                                    name.clear();
                                                    purpose.clear();
                                                    idNumber.clear();
                                                  });
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Successfuly added queue'),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                }else{
                                                  setState(() {
                                                    userId.clear();
                                                    email.clear();
                                                    name.clear();
                                                    purpose.clear();
                                                    idNumber.clear();
                                                  });
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Failed to add queue'),
                                                    ),
                                                  );
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
                                              setState(() {
                                                userId.clear();
                                                email.clear();
                                                name.clear();
                                                purpose.clear();
                                                idNumber.clear();
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
                                  ]),
                            ),
                          );
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
                              width: 50, // Replace with desired width
                              height: 50, // Replace with desired height
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25), // Half of the width or height for a perfect circle
                                child: Image(
                                  image: NetworkImage(snapshot.data![index].profilePic??'https://scontent.fdvo5-1.fna.fbcdn.net/v/t39.30808-6/324429893_692617042404789_8825582010059206302_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEuGGRS4j1TRnpWy-X7IciFiSnhuT21QT-JKeG5PbVBP8vei6WwmkTDRRj7Yshbp_oOgXKi9I5yuhVxBQGTA9ct&_nc_ohc=cR43Oe7orLkAX8oqv9e&_nc_ht=scontent.fdvo5-1.fna&oh=00_AfBVoA5lCXiUjLB0d8bKiG7RALtAeq036ggnmpmJJW1XTw&oe=649E83B4'), // Replace with your image URL
                                  width: 40, // Replace with desired image width
                                  height: 40, // Replace with desired image height
                                ),
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
                            const SizedBox(height: 8.0),
                            Text(
                                "Current Queue: ${snapshot.data![index].count??"0"}",
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
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

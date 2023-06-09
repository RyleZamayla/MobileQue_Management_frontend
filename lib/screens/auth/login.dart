import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/provider/db_provider.dart';
import 'package:mobilequemanagement_frontend/screens/admin_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/api_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DBProvider? dbProvider;
  apiProvider api = apiProvider();
  String? errorMessage = '';
  bool _passwordVisible = false;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : "$errorMessage",
      style: const TextStyle(color: Colors.red),
    );
  }

  @override
  void initState() {
    dbProvider = DBProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_student.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'QUEUE SYSTEM',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF05046a),
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.black),
                      hintText: 'Enter your email',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.red, width: 4.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.red, width: 4.0),
                      ),
                    ),
                    validator: (val) {
                      if (!(val!.isEmpty) &&
                          !RegExp(
                              r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?(?:\.[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?)*$")
                              .hasMatch(val)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    controller: _controllerPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black),
                      hintText: 'Enter your password',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.red, width: 4.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.red, width: 4.0),
                      ),

                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _errorMessage(),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> userInfoMap = {
                          'email': _controllerEmail.text,
                          'password': _controllerPassword.text
                        };
                        var response = await api.postLogin(userInfoMap, 'auth/login');
                        if (response != 'Failed to login') {
                          prefs.setString('userId', '${response['user']['_id']}');
                          prefs.setString('token', '${response['accessToken']}');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext ctx) =>
                                  const adminDashboard(),
                            ),
                          );
                        } else {
                          setState(() {
                            errorMessage = 'Failed to login';
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
                          const Size(150.0,
                              48.0)),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
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
}
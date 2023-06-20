import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/screens/admin_dashboard.dart';

import '../../provider/api_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  apiProvider api = apiProvider();
  String? errorMessage = '';
  bool _passwordVisible = false;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Widget _errorMessage(){
    return Text (errorMessage == '' ? '' : "$errorMessage",style: const TextStyle(color: Colors.red),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key:formKey,
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  const SizedBox(
                    height: 300,
                    width: 300,
                    child: InkWell(
                      child: Image(
                        image: AssetImage("assets/background_student.jpg"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 2.0))),
                    validator: (val) {
                      if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?(?:\.[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?)*$").hasMatch(val)){
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30,),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    controller: _controllerPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                      // Here is key idea
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toggle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  _errorMessage(),
                  ElevatedButton(
                    onPressed: ()async{
                      if (formKey.currentState!.validate()){
                        Map<String,dynamic> userInfoMap = {
                          "email": _controllerEmail.text,
                          "password": _controllerPassword.text
                        };
                        var response = await api.postLogin(userInfoMap, "auth/login");
                        if(response != "Failed to login"){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (BuildContext ctx) => adminDashboard(futureAdmin: response)));
                        }else{
                          setState(() {
                            errorMessage = "Failed to login";
                          });
                        }
                      }
                    },
                    child: Text('Login'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                    ),
                  )
                  // _loginOrRegisterButton(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

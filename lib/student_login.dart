import 'package:flutter/material.dart';
import 'package:mobilequemanagement_frontend/qr_scanner.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfafafa),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20.0),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF05046a)),
                labelText: 'Email',
                labelStyle: const TextStyle(color: Color(0xFF05046a)),
                border: const OutlineInputBorder(),
                focusedBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF05046a)),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),

            const SizedBox(height: 10.0),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF05046a),),
                labelText: 'Password',
                labelStyle: const TextStyle(color: Color(0xFF05046a)),
                border:  const OutlineInputBorder(),
                focusedBorder:  OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.amber),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF05046a)),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF05046a)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    )
                  )
                ),
                child: const Text('Signup', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QrScanner()),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFF05046a)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        )
                    )
                ),
                child: const Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

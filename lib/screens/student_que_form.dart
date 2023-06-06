import 'package:flutter/material.dart';

class QueForm extends StatefulWidget {
  const QueForm({Key? key}) : super(key: key);

  @override
  _QueFormState createState() => _QueFormState();
}

class _QueFormState extends State<QueForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentNumberController = TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentEmailController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  String? _studentNumberError;

  @override
  void dispose() {
    _studentNumberController.dispose();
    _studentNameController.dispose();
    _studentEmailController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _studentNumberController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.safety_check_outlined, color: Color(0xFF05046a)),
                  labelText: 'Student Number',
                  labelStyle: const TextStyle(color: Color(0xFF05046a)),
                  errorText: _studentNumberError,
                  errorStyle: const TextStyle(fontSize: 12.0), // Customize the error text style
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF05046a)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your student number';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _studentNumberError = null; // Clear the error text on change
                  });
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _studentNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                      Icons.person_2_outlined,
                      color: Color(0xFF05046a)),
                  labelText: 'Student Name',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _studentEmailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xFF05046a)),
                  labelText: 'Student Email',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _purposeController,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                      Icons.message_outlined,
                      color: Color(0xFF05046a)),
                  labelText: 'Purpose for transaction',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your purpose';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String studentNumber = _studentNumberController.text;
                            String studentName = _studentNameController.text;
                            String studentEmail = _studentEmailController.text;
                            String purpose = _purposeController.text;

                            _studentNumberController.clear();
                            _studentNameController.clear();
                            _studentEmailController.clear();
                            _purposeController.clear();
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF05046a)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                )
                            )
                        ),
                        child: const Text('Submit'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: SizedBox(
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _studentNumberController.clear();
                            _studentNameController.clear();
                            _studentEmailController.clear();
                            _purposeController.clear();
                          }
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF05046a)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                )
                            )
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

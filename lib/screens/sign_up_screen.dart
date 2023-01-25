import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password, _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50.0),
              const Text(
                "Sign Up",
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8.0,
                child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  //height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Name',
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: Colors.black))),
                            validator: (input) => input!.isEmpty
                                ? 'Please enter your name'
                                : null,
                            onSaved: (input) => _name = input!,
                          ),
                          const SizedBox(height: 20.0),

                          const SizedBox(height: 20.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.black))),
                            validator: (input) => input!.length < 6
                                ? 'Password must be at least 6 characters'
                                : null,
                            onSaved: (input) => _password = input!,
                            obscureText: true,
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 20.0),
                          FlatButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // Send data to server
                              }
                            },
                            child: const Text(
                              "Sign Up",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            color: Colors.black,
                          ),
                          const SizedBox(height: 20.0),
                          FlatButton(
                            onPressed: () {
                              // navigate to login screen
                            },
                            child: const Text(
                              "Already have an account? Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

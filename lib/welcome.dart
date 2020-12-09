import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:todofirebase/name_page.dart';
import 'components/rounded_button.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to ToDo App",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "     - by M G Christopher",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RoundedButton(
                text: "Get Started!!",
                press: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => NamePage()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

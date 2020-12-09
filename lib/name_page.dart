import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todofirebase/components/rounded_button.dart';
import 'package:todofirebase/components/rounded_input_field.dart';
import 'package:todofirebase/components/theme_color.dart';
import 'package:todofirebase/home_page.dart';
import 'package:todofirebase/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController myname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    void proceed() {
      if (validateAndSave()) {
        addUser(myname.text, phone.text);
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => HomePage()),
        );
      }
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please Enter your Name",
                style: TextStyle(fontSize: 30, color: secondColor),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      RoundedInputField(
                        hintText: "Your Name",
                        controller: myname,
                      ),
                      RoundedInputField(
                        icon: Icons.phone,
                        hintText: "Phone Number",
                        controller: phone,
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              RoundedButton(
                text: "Proceed",
                press: () {
                  proceed();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  addUser(myname, phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', myname);
    await prefs.setString('id', myname + phone);
    setState(() {
      user = myname;
      id = myname + phone;
    });
  }
}

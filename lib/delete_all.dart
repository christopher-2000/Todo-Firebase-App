import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todofirebase/components/rounded_button.dart';
import 'package:todofirebase/components/theme_color.dart';
import 'package:todofirebase/welcome.dart';

class DeleteUsers extends StatefulWidget {
  @override
  _DeleteUsersState createState() => _DeleteUsersState();
}

class _DeleteUsersState extends State<DeleteUsers> {
  void goToWelcome() {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => Welcome(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          "Delete User",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: RoundedButton(
              color: Colors.red,
              text: "Delete User",
              press: () {
                _showMyDialog();
              },
            ),
          )),
    );
  }

  clean() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are You Sure'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "This will result in the deletion of ur account and all the todos."),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  TextButton(
                    child: Text('Remove'),
                    onPressed: () {
                      clean();
                      goToWelcome();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todofirebase/components/theme_color.dart';
import 'package:todofirebase/home_page.dart';
import 'package:todofirebase/main.dart';
import 'package:todofirebase/name_page.dart';
import 'package:intl/intl.dart';

class AddNewTodo extends StatefulWidget {
  @override
  _AddNewTodoState createState() => _AddNewTodoState();
}

class _AddNewTodoState extends State<AddNewTodo> {
  final todoKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _deadline = TextEditingController();
  DateTime dt;
  TimeOfDay time;

  @override
  void initState() {
    super.initState();
    dt = DateTime.now();
    time = TimeOfDay.now();
  }

  bool validateAndSave() {
    final form = todoKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void addTodb() {
    if (validateAndSave()) {
      var formatDate = DateFormat('MMM d, yyyy');
      var formatTime = DateFormat('EEEE');

      String ddate = formatDate.format(dt);
      String dtime = formatTime.format(dt) + ", ${time.hour} : ${time.minute}";
      String titleString = _title.text;
      String desString = _description.text;
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.reference();

      var data = {
        "id": id,
        "title": titleString,
        "description": desString,
        "date": ddate,
        "time": dtime,
        "user": user,
      };
      databaseReference.child("todos").push().set(data);
      goHome();
    }
  }

  void goHome() {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => HomePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          "Add a Todo",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: todoKey,
        child: Column(
          children: [
            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black, blurRadius: 5.0),
                  ],
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        return value.isEmpty ? "Please Add a title" : null;
                      },
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _title,
                      decoration: InputDecoration(
                        hintText: "Add a Title",
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        return value.isEmpty
                            ? "Please Add a description"
                            : null;
                      },
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      controller: _description,
                      decoration: InputDecoration(
                        hintText: "Description",
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Pick DeadLine ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        _pickDate();
                      },
                      child: Container(
                          child: Text(
                        "Date : ${dt.day} / ${dt.month} / ${dt.year}",
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    FlatButton(
                      onPressed: () {
                        _pickTime();
                      },
                      child: Container(
                          child: Text(
                        "Time : ${time.hour}:${time.minute}",
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: FlatButton(
        child: Container(
          width: 120,
          margin: EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            color: primayColor,
            border: Border.all(color: secondColor),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
            child: Text(
              "Add",
              style: TextStyle(
                  color: secondColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onPressed: () {
          addTodb();
        },
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 100),
      initialDate: dt,
    );
    if (date != null) {
      setState(() {
        dt = date;
      });
    }
  }

  _pickTime() async {
    TimeOfDay dtime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (dtime != null) {
      setState(() {
        time = dtime;
      });
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todofirebase/components/roundSmall.dart';
import 'package:todofirebase/components/rounded_button.dart';
import 'package:todofirebase/components/theme_color.dart';
import 'package:todofirebase/components/todo_fom.dart';
import 'package:todofirebase/delete_all.dart';
import 'package:todofirebase/main.dart';
import 'package:todofirebase/name_page.dart';
import 'package:todofirebase/newTodo.dart';
import 'package:todofirebase/welcome.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todolist = [];

  void deleteTodo(delid) {
    FirebaseDatabase.instance.reference().child("todos").child(delid).remove();

    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => HomePage(),
        ));
  }

  void newTodo() {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => AddNewTodo(),
        ));
  }

  void goToDeleteUser() {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => DeleteUsers(),
        ));
  }

  @override
  void initState() {
    super.initState();

    try {
      todolist.clear();
      DatabaseReference postRef =
          FirebaseDatabase.instance.reference().child("todos");

      postRef.once().then((DataSnapshot snap) {
        var datas = snap.value;
        List keyL = datas.keys.toList()..sort();

        //print(keys);

        //print(keyL);

        for (var i in keyL) {
          if (datas[i]['id'] == id) {
            Todo todos = new Todo(datas[i]['title'], datas[i]['description'],
                datas[i]['date'], datas[i]['time'], i);

            todolist.add(todos);
          }
        }
        print("todo length: ${todolist.length}");
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Todo",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              FlatButton(
                  onPressed: goToDeleteUser,
                  child: Icon(
                    Icons.settings,
                    color: secondColor,
                  )),
            ],
          )),
      body: todolist.length == 0
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Container(
                        width: size.width,
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Hi $user, Dont forget these",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Press on the +Todo Button to add Your Todo here",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "DeadLine",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Date : Add date here",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Time : Add Time Here",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])),
              ),
            )
          : ListView.builder(
              itemCount: todolist.length,
              itemBuilder: (context, index) {
                return todoUI(
                  todolist[index].title,
                  todolist[index].description,
                  todolist[index].ddate,
                  todolist[index].dtime,
                  todolist[index].delete_id,
                );
              },
            ),
      floatingActionButton: FlatButton(
        child: Container(
          width: 160,
          margin: EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            color: primayColor,
            border: Border.all(color: secondColor),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                    color: secondColor,
                    size: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Todo",
                    style: TextStyle(
                        color: secondColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        onPressed: () {
          newTodo();
        },
      ),
    );
  }

  Widget todoUI(String title, String description, String date, String time,
      String delid) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "DeadLine",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Date : $date",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "Date : $time",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            RoundSmall(
              text: "Delete Todo",
              color: bgColor,
              press: () {
                _showMyDialog(delid);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(delid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Done this Todo?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "This Todo will be removed from the list. Please press cancel if u haven't done it"),
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
                      deleteTodo(delid);
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

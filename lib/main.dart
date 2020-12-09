import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todofirebase/home_page.dart';
import 'package:todofirebase/name_page.dart';
import 'welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

String user, id;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    getUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "todo App",
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: user == null ? Welcome() : HomePage(),
    );
  }

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    //Return String
    final String name = await prefs.getString('name');
    final String ids = await prefs.getString('id');

    setState(() {
      user = name;
      id = ids;
    });
  }
}

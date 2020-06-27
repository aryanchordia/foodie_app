import 'package:flutter/material.dart';
import 'auth.dart';
import 'root_page.dart';



void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'foodie',
      home: new RootPage(auth: new Auth()),
    );
  }
}
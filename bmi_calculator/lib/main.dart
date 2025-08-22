import 'package:flutter/material.dart';
import 'cal.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey[100],
        scaffoldBackgroundColor: Colors.blueGrey[900],
      ),
      home: cal(),
    );
  }
}

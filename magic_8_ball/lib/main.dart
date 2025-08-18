import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int ballVariable = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 6.0,
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          title: Text(
            'Ask Me Anything!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: TextButton(
              onPressed: () {
                setState(() {
                  ballVariable = Random().nextInt(5) + 1;
                });
              },
              child: Image.asset(
                'images/ball$ballVariable.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

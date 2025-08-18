import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red[400],
        appBar: AppBar(
          shadowColor: Colors.black,
          elevation: 3.0,
          backgroundColor: Colors.red[400],
          title: Center(child: Text('Dicee!')),
        ),
        body: Dice(),
      ),
    );
  }
}

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int leftDice = 1;
  int rightDice = 3;

  void state() {
    setState(() {
      leftDice = Random().nextInt(6) + 1;
      rightDice = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                state();
              },
              child: Image(image: AssetImage('images/dice$leftDice.png')),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                state();
              },
              child: Image(image: AssetImage('images/dice$rightDice.png')),
            ),
          ),
        ],
      ),
    );
  }
}

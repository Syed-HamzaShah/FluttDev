import 'package:flutter/material.dart';

class cardCHILD extends StatelessWidget {
  const cardCHILD({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 100.0, color: Colors.white),
        SizedBox(height: 5.0),
        Text(text, style: TextStyle(fontSize: 15.0, color: Colors.white)),
      ],
    );
  }
}

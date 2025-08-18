import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal[800],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/img.jpg'),
                radius: 60.0,
              ),
              Text(
                'Syed Hamza Shah',
                style: TextStyle(
                  // fontFamily: 'Pacifico',
                  fontSize: 20.0,
                  color: const Color.fromARGB(255, 23, 35, 29),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Flutter Developer',
                style: TextStyle(
                  // fontFamily: 'SourceSansPro',
                  fontSize: 16.0,
                  color: const Color.fromARGB(191, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    '+92 333 1234567',
                    style: TextStyle(color: Colors.teal[800], fontSize: 14.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    'hamzashah@gmail.com',
                    style: TextStyle(color: Colors.teal[800], fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alert Dialog App',
      home: AlertDialogApp(),
    );
  }
}

class AlertDialogApp extends StatefulWidget {
  const AlertDialogApp({super.key});

  @override
  State<AlertDialogApp> createState() => _AlertDialogAppState();
}

class _AlertDialogAppState extends State<AlertDialogApp> {
  Future<void> showAlertDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: Text(
            'Simple Alert Dialog',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'This is Simple Alert Dialog',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showCustomAlertDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 250,
                width: 200,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 70, 10, 70),
                  child: Column(
                    children: [
                      Text(
                        'This is Custom Alert Dialog',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          // fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 50,
                  child: Image(image: AssetImage('assets/img.jpg')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 100.0,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'AlertDialogApp!',
            style: TextStyle(
              color: const Color.fromARGB(255, 167, 210, 231),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.grey[800],
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // First Button - Modern Purple
              ElevatedButton(
                onPressed: () {
                  showAlertDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rectangular
                  ),
                  elevation: 6,
                  shadowColor: Colors.deepPurpleAccent,
                ),
                child: const Text(
                  "Purple Button",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              // Second Button - Outlined Gradient Style
              ElevatedButton(
                onPressed: () {
                  showCustomAlertDialog();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Orange Outline",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

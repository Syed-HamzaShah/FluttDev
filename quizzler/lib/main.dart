import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int number = 0;

  void checkLength() {
    if (scoreKeeper.length == 13) {
      number = 0;
      Alert(
        context: context,
        type: AlertType.info,
        title: "Quiz Finished",
        desc: "You have completed the quiz!",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                scoreKeeper.clear();
              });
            },
            width: 120,
          ),
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                QuestionBank().getQuestion(number).questionText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 20.0),
              ),
              child: Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                setState(() {
                  if (QuestionBank().getQuestion(number).questionNumber) {
                    scoreKeeper.add(Icon(Icons.check, color: Colors.green));
                  } else {
                    scoreKeeper.add(Icon(Icons.close, color: Colors.red));
                  }
                  number++;
                  checkLength();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (!QuestionBank().getQuestion(number).questionNumber) {
                    scoreKeeper.add(Icon(Icons.check, color: Colors.green));
                  } else {
                    scoreKeeper.add(Icon(Icons.close, color: Colors.red));
                  }
                  number++;
                  checkLength();
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 20.0),
              ),
              child: Text(
                'False',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Row(children: <Widget>[...scoreKeeper]),
      ],
    );
  }
}

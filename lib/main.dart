// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:quiz_app/Quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizapp());
}

Quizbrain quizbrain = Quizbrain();

class Quizapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizpage(),
          ),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Icon> scorekeeper = [];
  // List<String> questions = [
  //   'You can lead a cow down stairs but not up stair',
  //   'Approximately one quarter of human bones are in the feet',
  //   'A slug blood is green'
  // ];
  // List<bool> answers = [false, true, true];
  void checkAnswer(bool userPickAnswer) {
    bool correctAnswer = quizbrain.getQuestionAnswer();
    setState(() {
      if (quizbrain.isFinished() == true) {
        Alert(
                context: context,
                title: "Finished",
                desc: "You\'ve reached the end of the quiz.")
            .show();
      }
      if (userPickAnswer == correctAnswer) {
        scorekeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scorekeeper.add(Icon(
          Icons.cancel,
          color: Colors.red,
        ));
      }
      quizbrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  quizbrain.getQuestionText(),
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 18,
                  ),
                ),
              ),
            )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                'true',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'false',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(children: scorekeeper)
      ],
    );
  }
}

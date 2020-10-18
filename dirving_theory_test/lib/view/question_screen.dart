import 'package:dirving_theory_test/bloc/questionBloc.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int questionNumber = 1;
  List<Question> questions;
  QuestionBloc questionBloc = QuestionBloc();

  @override
  Widget build(BuildContext context) {
    questionBloc.readQuestionsFromFile();
    return Scaffold(
        appBar: AppBar(
          title: Text("Q1 of 757"),
        ),
        body: StreamBuilder<List<Question>>(
          stream: questionBloc.questions,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.length > 0)
              return Column(
                children: [
                  Text(snapshot.data[0].question),
                  RaisedButton(
                      child: Text(snapshot.data[0].answer1), onPressed: () {}),
                  RaisedButton(
                      child: Text(snapshot.data[0].answer2), onPressed: () {}),
                  RaisedButton(
                      child: Text(snapshot.data[0].answer3), onPressed: () {}),
                  RaisedButton(
                      child: Text(snapshot.data[0].answer4), onPressed: () {}),
                ],
              );
            else
              return Column();
          },
        ));
  }
}

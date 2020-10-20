import 'package:dirving_theory_test/bloc/questionBloc.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {

 final QuestionBloc questionBloc;

 QuestionScreen(this.questionBloc);

  @override
  _QuestionScreenState createState() => _QuestionScreenState(questionBloc);
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _questionNumber = 0;
  List<Question> questions;
  QuestionBloc questionBloc;

  _QuestionScreenState(this.questionBloc);

  @override
  Widget build(BuildContext context) {
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
                  Text(snapshot.data[_questionNumber].question),
                  RaisedButton(
                      child: Text(snapshot.data[_questionNumber].answer1),
                      onPressed: () {}),
                  RaisedButton(
                      child: Text(snapshot.data[_questionNumber].answer2),
                      onPressed: () {}),
                  RaisedButton(
                      child: Text(snapshot.data[_questionNumber].answer3),
                      onPressed: () {}),
                  RaisedButton(
                      child: Text(snapshot.data[_questionNumber].answer4),
                      onPressed: () {}),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: () {
                            setState(() {
                              _questionNumber--;
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: () {
                            setState(() {
                              _questionNumber++;
                            });
                          }),
                    ],
                  )
                ],
              );
            else
              return Column();
          },
        ));
  }
}

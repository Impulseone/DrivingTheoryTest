import 'package:dirving_theory_test/bloc/question_bloc.dart';
import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/database/model/answered_question.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text("Q1 of 757"),
      ),
      body: StreamBuilder<List<Question>>(
        stream: questionBloc.questions,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            Question question = snapshot.data[_questionNumber];
            String rightAnswer = question.findRightAnswer(question.rightAnswer);
            return Column(
              children: [
                progressIndicator(),
                questionText(question),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: [
                      answerButton(question, 1),
                      answerButton(question, 2),
                      answerButton(question, 3),
                      answerButton(question, 4),
                    ],
                  ),
                )
              ],
            );
          } else
            return Column();
        },
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  iconSize: 50,
                  icon: Icon(Icons.arrow_left),
                  onPressed: () {
                    setState(() {
                      _questionNumber--;
                    });
                  }),
              IconButton(icon: Icon(Icons.info), onPressed: () {}),
              IconButton(
                  iconSize: 50,
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    setState(() {
                      _questionNumber++;
                    });
                  }),
            ],
          )),
    );
  }

  Widget progressIndicator() {
    return LinearProgressIndicator(
      value: 10,
      minHeight: 10,
      backgroundColor: Colors.white,
    );
  }

  Widget questionText(Question question) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height / 2.65,
        child: Text(question.question,
            style: TextStyle(color: Colors.white, fontSize: 16)));
  }

  Widget answerButton(Question question, int numberOfAnswer) {
    String answer = findQuestionAnswer(question, numberOfAnswer);
    String rightAnswer = question.findRightAnswer(question.rightAnswer);
    return Padding(
        padding: EdgeInsets.only(left: 1, right: 1, top: 6),
        child: SizedBox(
          width: 500.0,
          height: 60,
          child: RaisedButton(
              color: Colors.green,
              child: Text(
                answer,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                if (answer == rightAnswer) {
                  DBProvider.db.insertAnsweredQuestion(AnsweredQuestion(
                      question.id, question.category, numberOfAnswer));
                }
              }),
        ));
  }

  String findQuestionAnswer(Question question, int numberOfAnswer) {
    switch (numberOfAnswer) {
      case 1:
        return question.answer1;
      case 2:
        return question.answer2;
      case 3:
        return question.answer3;
      case 4:
        return question.answer4;
      default:
        return question.answer1;
    }
  }
}

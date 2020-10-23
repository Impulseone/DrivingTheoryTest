import 'package:dirving_theory_test/bloc/questionBloc.dart';
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
    getAnsweredQuestions();
    return Scaffold(
        appBar: AppBar(
          title: Text("Q1 of 757"),
        ),
        body: StreamBuilder<List<Question>>(
          stream: questionBloc.questions,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              Question question = snapshot.data[_questionNumber];
              String rightAnswer =
                  question.findRightAnswer(question.rightAnswer);
              return Column(
                children: [
                  Text(question.question),
                  RaisedButton(
                      child: Text(question.answer1),
                      onPressed: () {
                        if (question.answer1 == rightAnswer) {
                          DBProvider.db.insertAnswer(AnsweredQuestion(
                              question.id, question.category, 1));
                        }
                      }),
                  RaisedButton(
                      child: Text(snapshot.data[_questionNumber].answer2),
                      onPressed: () {
                        if (question.answer2 == rightAnswer) {
                          DBProvider.db.insertAnswer(AnsweredQuestion(
                              question.id, question.category, 1));
                        }
                      }),
                  RaisedButton(
                      child: Text(snapshot.data[_questionNumber].answer3),
                      onPressed: () {
                        if (question.answer3 == rightAnswer) {
                          DBProvider.db.insertAnswer(AnsweredQuestion(
                              question.id, question.category, 1));
                        }
                      }),
                  RaisedButton(
                      child: Text(snapshot.data[_questionNumber].answer4),
                      onPressed: () {
                        if (question.answer4 == rightAnswer) {
                          DBProvider.db.insertAnswer(AnsweredQuestion(
                              question.id, question.category, 1));
                        }
                      }),
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
            } else
              return Column();
          },
        ));
  }

  void getAnsweredQuestions()async{
    List<AnsweredQuestion> list = List();
    list = await DBProvider.db.getAnsweredQuestions();
    print(list.length);
  }
}

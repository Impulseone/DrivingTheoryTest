import 'package:dirving_theory_test/model/question.dart';
import 'package:flutter/material.dart';

class AnsweredQuestionReviewScreen extends StatefulWidget {
  final List<Question> _questions;

  AnsweredQuestionReviewScreen(this._questions);

  @override
  _AnsweredQuestionReviewScreenState createState() =>
      _AnsweredQuestionReviewScreenState(_questions);
}

class _AnsweredQuestionReviewScreenState
    extends State<AnsweredQuestionReviewScreen> {
  List<Question> _questions;
  int selectedQuestion = 1;

  _AnsweredQuestionReviewScreenState(this._questions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Q$selectedQuestion of ${_questions.length}"),
      ),
      body: Container(),
    );
  }
}

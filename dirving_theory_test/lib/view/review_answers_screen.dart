import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/answered_question_review_screen.dart';
import 'package:flutter/material.dart';

class ReviewAnswersScreen extends StatefulWidget {
  final List<Question> _questions;

  ReviewAnswersScreen(this._questions);

  @override
  _ReviewAnswersScreenState createState() =>
      _ReviewAnswersScreenState(_questions);
}

class _ReviewAnswersScreenState extends State<ReviewAnswersScreen> {
  List<Question> _questions;

  _ReviewAnswersScreenState(this._questions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Review Answers",
          style: CustomTextStyle.engTextStyleHeadline(context),
        ),
        backgroundColor: Colors.black,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return GestureDetector(
            onTap: _openAnswersReviewScreen,
            child: Card(
              child: Text(_questions[index].question),
            ),
          );
        });
  }

  void _openAnswersReviewScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctxt) => AnsweredQuestionReviewScreen(_questions)));
  }
}

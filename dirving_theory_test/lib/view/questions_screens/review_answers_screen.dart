import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/questions_screens/answered_question_review_screen.dart';
import 'package:flutter/material.dart';

class ReviewAnswersScreen extends StatefulWidget {
  final List<Question> _questions;
  final List<Question> _trueAnsweredQuestions;
  final Map<int, String> _selectedAnswers;

  ReviewAnswersScreen(
      this._questions, this._trueAnsweredQuestions, this._selectedAnswers);

  @override
  _ReviewAnswersScreenState createState() => _ReviewAnswersScreenState(
      _questions, _trueAnsweredQuestions, _selectedAnswers);
}

class _ReviewAnswersScreenState extends State<ReviewAnswersScreen> {
  final List<Question> _questions;
  final List<Question> _trueAnsweredQuestions;
  final Map<int, String> _selectedAnswers;

  _ReviewAnswersScreenState(
      this._questions, this._trueAnsweredQuestions, this._selectedAnswers);

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
              onTap: _openAnsweredQuestionReviewScreen,
              child: _questionTileWidget(index));
        });
  }

  Widget _questionTileWidget(int index) {
    return Container(
        height: 139,
        margin: EdgeInsets.only(top: 10, left: 15, right: 15),
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        color: _trueAnsweredQuestions.contains(_questions[index])
            ? Colors.green
            : Colors.red,
        child: Center(
            child: Column(children: [
          Text(
            _getEngText(_questions[index].question),
            style: CustomTextStyle.engTextStyleMenu(context),
          ),
          Text(
            _getRusText(_questions[index].question),
            style: CustomTextStyle.rusTextStyleMenuBig(context),
          ),
        ])));
  }

  void _openAnsweredQuestionReviewScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctxt) => AnsweredQuestionReviewScreen(_questions, _selectedAnswers)));
  }

  String _getRusText(String question) {
    List<String> split = question.split(";");
    if (split.length < 2)
      return split[0];
    else
      return split[1];
  }

  String _getEngText(String question) {
    return question.split(";")[0];
  }
}

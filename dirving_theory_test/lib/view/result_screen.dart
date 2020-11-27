import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/menu_screens/home_page.dart';
import 'package:dirving_theory_test/view/review_answers_screen.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final List<Question> _allQuestions;
  final List<Question> _trueAnsweredQuestions;

  ResultScreen(this._allQuestions, this._trueAnsweredQuestions);

  @override
  _ResultScreenState createState() =>
      _ResultScreenState(_allQuestions, _trueAnsweredQuestions);
}

class _ResultScreenState extends State<ResultScreen> {
  final List<Question> _allQuestions;
  final List<Question> _trueAnsweredQuestions;

  _ResultScreenState(this._allQuestions, this._trueAnsweredQuestions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: _appBarTitle()),
      body: _body(),
    );
  }

  Widget _appBarTitle() {
    return Text(
      "Test Results",
      style: CustomTextStyle.engTextStyleHeadline(context),
    );
  }

  Widget _body() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _answeredCorrectlyText(_allQuestions, _trueAnsweredQuestions),
        SizedBox(
          height: 40,
        ),
        _reviewAnswersButton(),
        _backToMenuButton()
      ],
    ));
  }

  Widget _answeredCorrectlyText(
      List<Question> allQuestions, List<Question> trueAnsweredQuestions) {
    return Text(
      "You have answered ${trueAnsweredQuestions.length} out of ${allQuestions.length} questions correctly.\nВы ответили верно на ${trueAnsweredQuestions.length} вопросов из ${allQuestions.length}.",
      style: CustomTextStyle.rusTextStyleHeadlineBlack(context),
    );
  }

  Widget _reviewAnswersButton() {
    return RaisedButton(
        child: Column(
          children: [
            Text(
              "Review Answers",
              style: CustomTextStyle.engTextStyleBody(context),
            ),
            Text(
              "Посмотреть ответы",
              style: CustomTextStyle.rusTextStyleBody(context),
            ),
          ],
        ),
        color: Colors.green,
        onPressed: _openReviewAnswersScreen);
  }

  Widget _backToMenuButton() {
    return RaisedButton(
        child: Column(
          children: [
            Text(
              "Main Menu",
              style: CustomTextStyle.engTextStyleBody(context),
            ),
            Text(
              "Главное меню",
              style: CustomTextStyle.rusTextStyleBody(context),
            ),
          ],
        ),
        color: Colors.green,
        onPressed: _openMenuScreen);
  }

  void _openReviewAnswersScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ReviewAnswersScreen(_allQuestions, _trueAnsweredQuestions)));
  }

  void _openMenuScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false);
  }
}

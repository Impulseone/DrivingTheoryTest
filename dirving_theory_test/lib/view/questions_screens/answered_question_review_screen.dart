import 'package:dirving_theory_test/bloc/question_bloc.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/questions_screens/question_info_screen.dart';
import 'package:flutter/material.dart';

class AnsweredQuestionReviewScreen extends StatefulWidget {
  final List<Question> _questions;
  final Map<int, String> _selectedAnswers;

  AnsweredQuestionReviewScreen(this._questions, this._selectedAnswers);

  @override
  _AnsweredQuestionReviewScreenState createState() =>
      _AnsweredQuestionReviewScreenState(_questions, _selectedAnswers);
}

class _AnsweredQuestionReviewScreenState
    extends State<AnsweredQuestionReviewScreen> {
  final List<Question> _questions;
  final QuestionBloc _questionBloc = QuestionBloc();
  final Map<int, String> _selectedAnswers;
  Question _selectedQuestion;
  int _questionNumber = 0;

  _AnsweredQuestionReviewScreenState(this._questions, this._selectedAnswers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green,
            title: _appBarTitle()),
        body: _body(),
        bottomNavigationBar: _bottomNavigationBar());
  }

  Widget _appBarTitle() {
    return Text("Q${_questionNumber + 1} of ${_questions.length}");
  }

  Widget _body() {
    _selectedQuestion = _questions[_questionNumber];
    return Column(
      children: [
        _progressIndicator(),
        _questionTextWidget(_selectedQuestion),
        Column(
          children: [
            _answer(_selectedQuestion, 1),
            _answer(_selectedQuestion, 2),
            _answer(_selectedQuestion, 3),
            _answer(_selectedQuestion, 4),
          ],
        ),
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bottomBarWidget(50, 50, Icons.keyboard_arrow_left, 50, () {
              _decreaseQuestionNumber();
            }),
            _bottomBarWidget(40, 40, Icons.info, 30, () {
              _toExplanationScreen();
            }),
            _bottomBarWidget(40, 40, Icons.favorite, 30, () {
              _questionBloc.insertQuestionIntoFavorites(_selectedQuestion);
            }),
            _bottomBarWidget(50, 50, Icons.keyboard_arrow_right, 50, () {
              _increaseQuestionNumber();
            }),
          ],
        ));
  }

  Widget _finishButton() {
    return RaisedButton(
        child: Container(
          width: 67,
          child: Text(
            "finish",
            style: CustomTextStyle.engTextStyleBodyAnswer(context),
          ),
        ),
        color: Colors.black,
        onPressed: () => _backToReviewAnswersScreen());
  }

  Widget _bottomBarWidget(double width, double height, IconData iconData,
      double iconSize, Function function) {
    if (iconData == Icons.keyboard_arrow_right &&
        _questionNumber + 1 == _questions.length)
      return _finishButton();
    else
      return GestureDetector(
          child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: width,
              height: height,
              child: Center(
                child: Icon(
                  iconData,
                  size: iconSize,
                ),
              )),
          onTap: () {
            function();
          });
  }

  Widget _progressIndicator() {
    double k = (_questionNumber + 1) / _questions.length;
    return LinearProgressIndicator(
      value: k,
      minHeight: 10,
      backgroundColor: Colors.white,
    );
  }

  Widget _questionTextWidget(Question question) {
    if (question.hasImage) {
      return _questionTextWithImage(question);
    } else
      return _questionTextWithoutImage(question);
  }

  Widget _questionTextWithImage(Question question) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.7,
      padding: EdgeInsets.only(top: 20,left: 15, right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    _getEngText(question.question),
                    style: CustomTextStyle.engTextStyleMenu(context),
                  ),
                  Text(
                    _getRusText(question.question),
                    style: CustomTextStyle.rusTextStyleMenu(context),
                  ),
                ],
              )),
          Container(
              height: 110,
              child: Image.asset("assets/${question.id}.jpg"))
        ],
      ),
    );
  }

  Widget _questionTextWithoutImage(Question question) {
    return Container(
        padding: EdgeInsets.only(top: 20,left: 15, right: 5),
        height: MediaQuery.of(context).size.height / 2.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getEngText(question.question),
              style: CustomTextStyle.engTextStyleMenu(context),
            ),
            Text(
              _getRusText(question.question),
              style: CustomTextStyle.rusTextStyleMenu(context),
            ),
          ],
        ));
  }

  Widget _answer(Question question, int numberOfAnswer) {
    String answer = _findQuestionAnswer(question, numberOfAnswer);
    String rightAnswer = question.findRightAnswer(question.rightAnswer);
    return Padding(
        padding: EdgeInsets.only(left: 1, right: 1, top: 6),
        child: SizedBox(
          width: 500.0,
          height: 52,
          child: Container(
            color: _getColor(rightAnswer, answer, question.id),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getEngText(answer),
                  style: answer == rightAnswer
                      ? CustomTextStyle.engTextStyleBodyBlackAnswer(context)
                      : CustomTextStyle.engTextStyleBodyAnswer(context),
                ),
                Text(
                  _getRusText(answer),
                  style: answer == rightAnswer
                      ? CustomTextStyle.rusTextStyleBodyBlackAnswer(context)
                      : CustomTextStyle.rusTextStyleBodyAnswer(context),
                ),
              ],
            ),
          ),
        ));
  }

  Color _getColor(String rightAnswer, String answer, int questionId) {
    if (answer == rightAnswer)
      return Colors.white;
    else {
      if (answer == _selectedAnswers[questionId])
        return Colors.red;
      else
        return Colors.green;
    }
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

  String _findQuestionAnswer(Question question, int numberOfAnswer) {
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

  void _decreaseQuestionNumber() {
    setState(() {
      if (_questionNumber > 0) _questionNumber--;
    });
  }

  void _increaseQuestionNumber() {
    setState(() {
      if (_questionNumber + 1 < _questions.length) _questionNumber++;
    });
  }

  void _toExplanationScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            QuestionInfoScreen(_selectedQuestion.explanation)));
  }

  void _backToReviewAnswersScreen() {
    Navigator.pop(context);
  }
}

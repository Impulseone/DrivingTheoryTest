import 'package:dirving_theory_test/bloc/question_bloc.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/questions_screens/question_info_screen.dart';
import 'package:flutter/material.dart';

import '../result_screen.dart';

class QuestionScreen extends StatefulWidget {
  final QuestionBloc questionBloc;

  QuestionScreen(this.questionBloc);

  @override
  _QuestionScreenState createState() => _QuestionScreenState(questionBloc);
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<Question> _allQuestions = new List();
  List<Question> _flaggedQuestions = new List();
  List<Question> _rightAnsweredQuestions = new List();

  QuestionBloc _questionBloc;

  Question _selectedQuestion;
  int _questionNumber = 0;

  _QuestionScreenState(this._questionBloc);

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

  Widget _bottomNavigationBar() {
    return BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bottomBarWidget(60, 60, Icons.keyboard_arrow_left, 60, () {
              _decreaseQuestionNumber();
            }),
            _bottomBarWidget(50, 50, Icons.flag, 40, () {
              _flaggedQuestions.add(_selectedQuestion);
            }),
            _bottomBarWidget(50, 50, Icons.info, 40, () {
              _toExplanationScreen();
            }),
            _bottomBarWidget(50, 50, Icons.favorite, 40, () {
              _questionBloc.insertQuestionIntoFavorites(_selectedQuestion);
            }),
            _bottomBarWidget(60, 60, Icons.keyboard_arrow_right, 60, () {
              _increaseQuestionNumber();
            }),
          ],
        ));
  }

  Widget _finishButton() {
    return RaisedButton(
        child: Text(
          "finish",
          style: CustomTextStyle.engTextStyleBody(context),
        ),
        color: Colors.black,
        onPressed: () =>
            _openResultScreen());
  }

  Widget _body() {
    return StreamBuilder<List<Question>>(
      stream: _questionBloc.questions,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
            _allQuestions = snapshot.data;
          _selectedQuestion = snapshot.data[_questionNumber];
          return Column(
            children: [
              _progressIndicator(),
              _questionTextWidget(_selectedQuestion),
              Column(
                children: [
                  _answerButton(_selectedQuestion, 1),
                  _answerButton(_selectedQuestion, 2),
                  _answerButton(_selectedQuestion, 3),
                  _answerButton(_selectedQuestion, 4),
                ],
              ),
            ],
          );
        } else
          return Column();
      },
    );
  }

  Widget _appBarTitle() {
    return StreamBuilder<List<Question>>(
        stream: _questionBloc.questions,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0)
            return Text("Q${_questionNumber + 1} of ${snapshot.data.length}");
          else
            return Text("Q${_questionNumber + 1} of 0");
        });
  }

  Widget _bottomBarWidget(double width, double height, IconData iconData,
      double iconSize, Function function) {
    if (iconData == Icons.keyboard_arrow_right &&
        _questionNumber + 1 == _allQuestions.length)
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
    double k = (_questionNumber + 1) / _allQuestions.length;
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
      height: MediaQuery.of(context).size.height / 2.3,
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
              height: 180,
              width: 180,
              child: Image.asset("assets/${question.id}.jpg"))
        ],
      ),
    );
  }

  Widget _questionTextWithoutImage(Question question) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height / 2.3,
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

  Widget _answerButton(Question question, int numberOfAnswer) {
    String answer = _findQuestionAnswer(question, numberOfAnswer);
    String rightAnswer = question.findRightAnswer(question.rightAnswer);
    return Padding(
        padding: EdgeInsets.only(left: 1, right: 1, top: 6),
        child: SizedBox(
          width: 500.0,
          height: 64,
          child: RaisedButton(
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getEngText(answer),
                    style: CustomTextStyle.engTextStyleBody(context),
                  ),
                  Text(
                    _getRusText(answer),
                    style: CustomTextStyle.rusTextStyleBody(context),
                  ),
                ],
              ),
              onPressed: () {
                _answerQuestion(answer,rightAnswer,question);
              }),
        ));
  }

  String _getRusText(String question) {
    return question.split(";")[1];
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

  void _answerQuestion(String answer, String rightAnswer, Question question){
    if(answer==rightAnswer){
      _rightAnsweredQuestions.add(question);
    }
    _questionBloc.insertAnsweredQuestion(
        question, answer, rightAnswer);
    setState(() {
      if (_questionNumber + 1 < _allQuestions.length) _questionNumber++;
    });
  }

  void _openResultScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) =>
                ResultScreen(_allQuestions, _rightAnsweredQuestions)));
  }

  void _decreaseQuestionNumber() {
    setState(() {
      if (_questionNumber > 0) _questionNumber--;
    });
  }

  void _increaseQuestionNumber() {
    setState(() {
      if (_questionNumber + 1 < _allQuestions.length) _questionNumber++;
    });
  }

  void _toExplanationScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            QuestionInfoScreen(_selectedQuestion.explanation)));
  }
}

import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/database/model/answered_question.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/questions_screens/question_info_screen.dart';
import 'package:flutter/material.dart';

class QuestionAfterSearchScreen extends StatefulWidget {
  final List<Question> questions;
  final Question selectedQuestion;

  QuestionAfterSearchScreen(this.questions, this.selectedQuestion);

  @override
  _QuestionAfterSearchScreenState createState() =>
      _QuestionAfterSearchScreenState();
}

class _QuestionAfterSearchScreenState extends State<QuestionAfterSearchScreen> {
  int questionNumber = 0;
  Question selectedQuestion;

  @override
  Widget build(BuildContext context) {
    if(selectedQuestion==null) selectedQuestion = widget.selectedQuestion;
    else selectedQuestion = widget.questions[questionNumber];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text("Q${questionNumber + 1} of ${widget.questions.length}")),
      body: Column(
        children: [
          _progressIndicator(),
          _questionTextWidget(selectedQuestion),
          Column(
            children: [
              _answerButton(selectedQuestion, 1),
              _answerButton(selectedQuestion, 2),
              _answerButton(selectedQuestion, 3),
              _answerButton(selectedQuestion, 4),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _bottomBarWidget(50, 50, Icons.keyboard_arrow_left, 50, () {
                _decreaseQuestionNumber();
              }),
              _bottomBarWidget(40, 40, Icons.flag, 30, () {}),
              _bottomBarWidget(40, 40, Icons.info, 30, () {
                _toExplanationScreen();
              }),
              _bottomBarWidget(40, 40, Icons.favorite, 30, () {}),
              _bottomBarWidget(50, 50, Icons.keyboard_arrow_right, 50, () {
                _increaseQuestionNumber();
              }),
            ],
          )),
    );
  }

  Widget _bottomBarWidget(double width, double height, IconData iconData,
      double iconSize, Function function) {
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
    return LinearProgressIndicator(
      value: (questionNumber+1) /widget.questions.length,
      minHeight: 10,
      backgroundColor: Colors.white,
    );
  }

  Widget _questionTextWidget(Question question) {
    print(question.id);
    if (question.hasImage) {
      return _questionTextWithImage(question);
    } else
      return _questionTextWithoutImage(question);
  }

  Widget _questionTextWithImage(Question question) {
    return Container(
      padding: EdgeInsets.only(top: 20,left: 30, right: 30),
      height: MediaQuery.of(context).size.height / 2.7,
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
        padding: EdgeInsets.only(top: 20,left: 30, right: 30),
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

  Widget _answerButton(Question question, int numberOfAnswer) {
    String answer = _findQuestionAnswer(question, numberOfAnswer);
    String rightAnswer = question.findRightAnswer(question.rightAnswer);
    return Padding(
        padding: EdgeInsets.only(left: 1, right: 1, top: 6),
        child: SizedBox(
          width: 500.0,
          height: 52,
          child: RaisedButton(
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getEngText(answer),
                    style: CustomTextStyle.engTextStyleBodyAnswer(context),
                  ),
                  Text(
                    _getRusText(answer),
                    style: CustomTextStyle.rusTextStyleBodyAnswer(context),
                  ),
                ],
              ),
              onPressed: () {
                if (answer == rightAnswer) {
                  DBProvider.db.insertAnsweredQuestion(AnsweredQuestion(
                      question.id, question.category, numberOfAnswer));
                }
                setState(() {
                  if (questionNumber + 1 <widget.questions.length) questionNumber++;
                });
              }),
        ));
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
      if (questionNumber > 0) questionNumber--;
    });
  }

  void _increaseQuestionNumber() {
    setState(() {
      if (questionNumber + 1 < widget.questions.length) questionNumber++;
    });
  }

  void _toExplanationScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            QuestionInfoScreen(selectedQuestion.explanation)));
  }
}

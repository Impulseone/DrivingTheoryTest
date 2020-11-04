import 'package:dirving_theory_test/bloc/question_bloc.dart';
import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/database/model/answered_question.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/question_info_screen.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final QuestionBloc questionBloc;

  QuestionScreen(this.questionBloc);

  @override
  _QuestionScreenState createState() => _QuestionScreenState(questionBloc);
}

class _QuestionScreenState extends State<QuestionScreen> {
  QuestionBloc questionBloc;
  Question selectedQuestion;
  int questionsSize = 0;
  int questionNumber = 0;

  _QuestionScreenState(this.questionBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: StreamBuilder<List<Question>>(
            stream: questionBloc.questions,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.length > 0)
                return Text(
                    "Q${questionNumber + 1} of ${snapshot.data.length}");
              else
                return Text("Q${questionNumber + 1} of 0");
            }),
      ),
      body: StreamBuilder<List<Question>>(
        stream: questionBloc.questions,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            if (questionsSize != snapshot.data.length)
              questionsSize = snapshot.data.length;
            selectedQuestion = snapshot.data[questionNumber];
            return Column(
              children: [
                progressIndicator(),
                questionWidget(selectedQuestion),
                Column(
                  children: [
                    answerButton(selectedQuestion, 1),
                    answerButton(selectedQuestion, 2),
                    answerButton(selectedQuestion, 3),
                    answerButton(selectedQuestion, 4),
                  ],
                ),
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
              bottomBarWidget(60, 60, Icons.keyboard_arrow_left, 60, () {
                decreaseQuestionNumber();
              }),
              bottomBarWidget(50, 50, Icons.flag, 40, () {}),
              bottomBarWidget(50, 50, Icons.info, 40, () {
                toExplanationScreen();
              }),
              bottomBarWidget(50, 50, Icons.favorite, 40, () {}),
              bottomBarWidget(60, 60, Icons.keyboard_arrow_right, 60, () {
                increaseQuestionNumber();
              }),
            ],
          )),
    );
  }

  void decreaseQuestionNumber() {
    setState(() {
      if (questionNumber > 0) questionNumber--;
    });
  }

  void increaseQuestionNumber() {
    setState(() {
      if (questionNumber + 1 < questionsSize) questionNumber++;
    });
  }

  void toExplanationScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            QuestionInfoScreen(selectedQuestion.explanation)));
  }

  Widget bottomBarWidget(double width, double height, IconData iconData,
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

  Widget progressIndicator() {
    double k = (questionNumber+1) / questionsSize;
    return LinearProgressIndicator(
      value: k,
      minHeight: 10,
      backgroundColor: Colors.white,
    );
  }

  Widget questionWidget(Question question) {
    if (question.hasImage) {
      return Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getEngText(question.question),
                    style: CustomTextStyle.engTextStyleBody(context),
                  ),
                  Text(
                    getRusText(question.question),
                    style: CustomTextStyle.rusTextStyleBody(context),
                  ),
                ],
              )),
          Container(height: 180, width: 180, child: Image.asset("assets/1.jpg"))
        ],
      );
    } else
      return Container(
          padding: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height / 2.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getEngText(question.question),
                style: CustomTextStyle.engTextStyleBody(context),
              ),
              Text(
                getRusText(question.question),
                style: CustomTextStyle.rusTextStyleBody(context),
              ),
            ],
          ));
  }

  String getRusText(String question) {
    return question.split(";")[1];
  }

  String getEngText(String question) {
    return question.split(";")[0];
  }

  Widget answerButton(Question question, int numberOfAnswer) {
    String answer = findQuestionAnswer(question, numberOfAnswer);
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
                    getEngText(answer),
                    style: CustomTextStyle.engTextStyleBody(context),
                  ),
                  Text(
                    getRusText(answer),
                    style: CustomTextStyle.rusTextStyleBody(context),
                  ),
                ],
              ),
              onPressed: () {
                if (answer == rightAnswer) {
                  DBProvider.db.insertAnsweredQuestion(AnsweredQuestion(
                      question.id, question.category, numberOfAnswer));
                }
                setState(() {
                  if (questionNumber + 1 < questionsSize) questionNumber++;
                });
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

import 'package:dirving_theory_test/bloc/search_question_bloc.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/questions_after_search_screen.dart';
import 'package:flutter/material.dart';

class SearchQuestionScreen extends StatefulWidget {
  @override
  _SearchQuestionScreenState createState() => _SearchQuestionScreenState();
}

class _SearchQuestionScreenState extends State<SearchQuestionScreen> {
  SearchQuestionBloc searchQuestionBloc = SearchQuestionBloc();
  List<Question> questions = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Search Questions"),
      ),
      body: Container(
          child: Column(
        children: [
          TextField(
            onSubmitted: (text) => searchQuestionBloc.searchQuestions(text),
          ),
          StreamBuilder(
              stream: searchQuestionBloc.questions,
              builder: (ctx, snap) {
                if (snap.hasData) {
                  questions = snap.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snap.data.length,
                      itemBuilder: (ctx, index) =>
                          questionWidget((snap.data[index] as Question)));
                } else
                  return Container();
              })
        ],
      )),
    );
  }

  Widget questionWidget(Question selectedQuestion) {
    return GestureDetector(
        onTap: () => openQuestion(selectedQuestion),
        child: Card(
            elevation: 2,
            child: questionTileWidget(selectedQuestion.question)));
  }

  Widget questionTileWidget(String text) {
    return Row(
      children: [
        Container(
          width: 330,
          height: 60,
          child: Text(text),
        ),
        Padding(padding: EdgeInsets.only(left: 40)),
        Icon(Icons.arrow_forward_ios)
      ],
    );
  }

  void openQuestion(Question selectedQuestion) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            QuestionAfterSearchScreen(questions, selectedQuestion)));
  }
}

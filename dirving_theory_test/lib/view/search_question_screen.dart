import 'package:dirving_theory_test/bloc/search_question_bloc.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:flutter/material.dart';

class SearchQuestionScreen extends StatefulWidget {
  @override
  _SearchQuestionScreenState createState() => _SearchQuestionScreenState();
}

class _SearchQuestionScreenState extends State<SearchQuestionScreen> {
  SearchQuestionBloc searchQuestionBloc = SearchQuestionBloc();

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
                if (snap.hasData)
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snap.data.length,
                      itemBuilder: (ctx, index) => Card(child: Text((snap.data[index] as Question).question),)
                          );
                else
                  return Container();
              })
        ],
      )),
    );
  }
}

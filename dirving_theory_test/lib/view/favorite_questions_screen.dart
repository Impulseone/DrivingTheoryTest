import 'package:dirving_theory_test/bloc/favorite_questions_bloc.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/questions_after_search_screen.dart';
import 'package:flutter/material.dart';

class FavoriteQuestionsScreen extends StatefulWidget {
  @override
  _FavoriteQuestionsScreenState createState() => _FavoriteQuestionsScreenState();
}

class _FavoriteQuestionsScreenState extends State<FavoriteQuestionsScreen> {
  FavoriteQuestionsBloc _favoriteQuestionsBloc = FavoriteQuestionsBloc();
  List<Question> questions = List();

  @override
  Widget build(BuildContext context) {
    _favoriteQuestionsBloc.getFavoriteQuestions();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Search Questions"),
      ),
      body: Container(
          child: Column(
            children: [
              StreamBuilder(
                  stream: _favoriteQuestionsBloc.questions,
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
        Icon(Icons.where_to_vote_outlined),
        Container(
          width: MediaQuery.of(context).size.width*0.8,
          child: Text(text),
        ),
        Padding(padding: EdgeInsets.only(left: 40)),
      ],
    );
  }

  void openQuestion(Question selectedQuestion) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            QuestionAfterSearchScreen(questions, selectedQuestion)));
  }
}

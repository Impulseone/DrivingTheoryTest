import 'dart:convert';

import 'package:dirving_theory_test/model/question.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class QuestionBloc {
  final BehaviorSubject<List<Question>> _questionController =
      BehaviorSubject<List<Question>>();

  Stream<List<Question>> get questions => _questionController.stream;

  Future<List<Question>> readQuestionsFromFile() async {
    List<Question> questions = List();
    String json = await rootBundle.loadString("assets/questions.json");
    final List<dynamic> response = jsonDecode(json);
    response.forEach((element) {
      Question question = Question.fromJson(element);
      questions.add(question);
    });
    _questionController.sink.add(questions);
    return questions;
  }

  void dispose() {
    _questionController.close();
  }
}

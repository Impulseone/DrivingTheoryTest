import 'dart:convert';

import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/extension/categories_provider.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class QuestionBloc {
  final BehaviorSubject<List<Question>> _questionController =
      BehaviorSubject<List<Question>>();

  final BehaviorSubject<List<Question>> _allQuestionsController =
  BehaviorSubject<List<Question>>();

  Stream<List<Question>> get questions => _questionController.stream;

  Stream<List<Question>> get allQuestions => _allQuestionsController.stream;

  void readAllQuestionsFromDb() async{
    List<Question> questions = List();
    questions = await DBProvider.db.getQuestions();
    _allQuestionsController.sink.add(questions);
  }

  Future<List<Question>> readQuestionsFromFile() async {
    List<Question> questions = List();
    String json = await rootBundle.loadString("assets/questions.json");
    final List<dynamic> response = jsonDecode(json);
    response.forEach((element) {
      Question question = Question.fromJson(element);
      questions.add(question);
    });
    return questions;
  }

  Future<List<Question>> getQuestionsForCategories(List<Category> categories) async {
    List<Question> result = List();
    categories.forEach((element) async {
      List<Question> categoryQuestions = await getQuestionsForCategory(element);
      result.addAll(categoryQuestions);
    });
    _questionController.sink.add(result);
    return result;
  }

  Future<List<Question>> getQuestionsForCategory(Category category) async {
    return await DBProvider.db.getQuestionsForCategory(category.engName);
  }

  void dispose() {
    _questionController.close();
    _allQuestionsController.close();
  }
}

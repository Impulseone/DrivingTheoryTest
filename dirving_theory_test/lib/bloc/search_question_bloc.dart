import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:rxdart/rxdart.dart';
import "package:dirving_theory_test/extension/string_extension.dart";

class SearchQuestionBloc {
  BehaviorSubject<List<Question>> _searchQuestionsController =
      BehaviorSubject<List<Question>>();

  Stream<List<Question>> get questions => _searchQuestionsController.stream;

  void searchQuestions(String text) async {
    List<Question> foundedQuestions = List();
    List<Question> questions = await DBProvider.db.getQuestions();
    questions.forEach((element) {
      if (element.question.contains(text) ||
          element.question.contains(text.toLowerCase()) ||
          element.question.contains(text.capitalize()))
        foundedQuestions.add(element);
    });
    _searchQuestionsController.sink.add(foundedQuestions);
  }

  void dispose() {
    _searchQuestionsController.sink.close();
  }
}

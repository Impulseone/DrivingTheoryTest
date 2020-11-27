import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/database/model/answered_question.dart';
import 'package:rxdart/rxdart.dart';

class AnsweredQuestionsBloc {
  final BehaviorSubject<List<AnsweredQuestion>> _answeredQuestionsController =
      BehaviorSubject<List<AnsweredQuestion>>();

  Stream<List<AnsweredQuestion>> get answeredQuestions =>
      _answeredQuestionsController.stream;

  void readAnsweredQuestions() async {
    List<AnsweredQuestion> answeredQuestions = List();
    answeredQuestions = await DBProvider.db.getAnsweredQuestions();
    _answeredQuestionsController.sink.add(answeredQuestions);
  }

  void dispose() {
    _answeredQuestionsController.close();
  }
}

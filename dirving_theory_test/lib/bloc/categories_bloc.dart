import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/database/model/answered_question.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesBloc {
  final BehaviorSubject<List<AnsweredQuestion>> _questionController =
      BehaviorSubject<List<AnsweredQuestion>>();

  Stream<List<AnsweredQuestion>> get questions => _questionController.stream;

  void readAnsweredQuestions() async {
    List<AnsweredQuestion> answeredQuestions = List();
    answeredQuestions = await DBProvider.db.getAnsweredQuestions();
    _questionController.sink.add(answeredQuestions);
  }

  void dispose(){
    _questionController.close();
  }
}

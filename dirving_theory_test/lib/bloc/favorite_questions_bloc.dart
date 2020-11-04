import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteQuestionsBloc {
  BehaviorSubject<List<Question>> _favoriteQuestionsController = BehaviorSubject<List<Question>>();

  Stream<List<Question>> get questions => _favoriteQuestionsController.stream;

  void getFavoriteQuestions() async {
    List<Question> favoriteQuestions  = await DBProvider.db.getFavoriteQuestions();
    _favoriteQuestionsController.sink.add(favoriteQuestions);
  }

  void dispose() {
    _favoriteQuestionsController.close();
  }
}

import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/database/model/answered_question.dart';

class CategoriesProvider {
 Future<Category> getCategoryInfo(String category)async{
    switch(category){
      case "all_categories": return await AllCategories().getCategory();
      default: return null;
    }
  }
}

abstract class Category {
  String name;
  int answered = 0;
  int correctly = 0;

  Future<Category> getCategory();
}

class AllCategories extends Category {
  String name = 'all_categories';

  @override
  Future<Category> getCategory() async {
    List<AnsweredQuestion> answeredQuestions = List();
    answeredQuestions = await DBProvider.db.getAnsweredQuestions();
    answered = answeredQuestions.length;
    answeredQuestions.forEach((element) {
      if (element.answerIsTrue==1) correctly += 1;
    });
    return this;
  }
}

class Alertness {}

class Attitude {}

class Documents {}

class HazardAwareness {}

class RoadAndTrafficSigns {}

class Incidents {}

class OtherTypesOfVehicle {}

class VehicleHandling {}

class MotorwayRules {}

class RulesOfTheRoad {}

class SafetyMargins {}

class SafetyAndVehicle {}

class VulnerableRoadUsers {}

class VehicleLoading {}

class Videos {}

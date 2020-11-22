import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesProvider {
  Future<List<Category>> generateCategoriesInfo() async {
    List<Category> categories = List();
    categories.add(AllCategories("All categories", 'Все категории', Icons.list,
        await _getCategoryQuestionsSize("All categories"), false));
    categories.add(Alertness("Alertness", 'Осторожность', Icons.vpn_key,
        await _getCategoryQuestionsSize("Alertness"), false));
    categories.add(Attitude("Attitude", 'Положение', Icons.tag_faces,
        await _getCategoryQuestionsSize("Attitude"), false));
    categories.add(Documents(
        "Documents",
        'Документы',
        Icons.library_books_sharp,
        await _getCategoryQuestionsSize("Documents"),
        false));
    categories.add(HazardAwareness(
        "Hazard awareness",
        'Осведомленность об опасности',
        Icons.warning_amber_outlined,
        await _getCategoryQuestionsSize("Hazard awareness"),
        false));
    categories.add(RoadAndTrafficSigns(
        "Road and traffic signs",
        'Дорога и дорожные знаки',
        Icons.traffic,
        await _getCategoryQuestionsSize("Road and traffic signs"),
        false));
    categories.add(Incidents(
        "Incidents, accidents and emergencies",
        'Происшествия, аварии и чрезвычайные ситуации',
        Icons.medical_services,
        await _getCategoryQuestionsSize("Incidents"),
        false));
    categories.add(OtherTypesOfVehicle(
        "Other types of vehicle",
        'Другие виды транспорта',
        Icons.bus_alert,
        await _getCategoryQuestionsSize("Other types of vehicle"),
        false));
    categories.add(VehicleHandling(
        "Vehicle handling",
        'Управление автомобилем',
        Icons.directions_car,
        await _getCategoryQuestionsSize("Vehicle handling"),
        false));
    categories.add(MotorwayRules(
        "Motorway rules",
        'Правила автомагистрали',
        Icons.add_road,
        await _getCategoryQuestionsSize("Motorway rules"),
        false));
    categories.add(RulesOfTheRoad(
        "Rules of the road",
        'Правила дороги',
        Icons.note_outlined,
        await _getCategoryQuestionsSize("Rules of the road"),
        false));
    categories.add(SafetyMargins("Safety margins", 'Запас прочности',
        Icons.speed, await _getCategoryQuestionsSize("Safety margins"), false));
    categories.add(SafetyAndVehicle(
        "Safety and your vehicle",
        'Безопасность и ваш автомобиль',
        Icons.build,
        await _getCategoryQuestionsSize("Safety"),
        false));
    categories.add(VulnerableRoadUsers(
        "Vulnerable road users",
        'Уязвимые участники дорожного движения',
        Icons.people,
        await _getCategoryQuestionsSize("Vulnerable road users"),
        false));
    categories.add(VehicleLoading(
        "Vehicle loading",
        'Загрузка автомобиля',
        Icons.car_rental,
        await _getCategoryQuestionsSize("Vehicle loading"),
        false));
    return categories;
  }

  Future<int> _getCategoryQuestionsSize(String category) async {
    List<Question> questions = List();
    if (category != "All categories")
      questions = await DBProvider.db.getQuestionsForCategory(category);
    else
      questions = await DBProvider.db.getQuestions();
    return questions.length;
  }
}

abstract class Category {
  String engName;
  String rusName;
  IconData iconData;
  int allQuestionsNumber;
  bool isChecked;

  Category(this.engName, this.rusName, this.iconData, this.allQuestionsNumber,
      this.isChecked);
}

class AllCategories extends Category {
  AllCategories(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class Alertness extends Category {
  Alertness(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class Attitude extends Category {
  Attitude(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class Documents extends Category {
  Documents(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class HazardAwareness extends Category {
  HazardAwareness(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class RoadAndTrafficSigns extends Category {
  RoadAndTrafficSigns(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class Incidents extends Category {
  Incidents(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class OtherTypesOfVehicle extends Category {
  OtherTypesOfVehicle(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class VehicleHandling extends Category {
  VehicleHandling(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class MotorwayRules extends Category {
  MotorwayRules(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class RulesOfTheRoad extends Category {
  RulesOfTheRoad(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class SafetyMargins extends Category {
  SafetyMargins(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class SafetyAndVehicle extends Category {
  SafetyAndVehicle(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class VulnerableRoadUsers extends Category {
  VulnerableRoadUsers(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class VehicleLoading extends Category {
  VehicleLoading(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

class Videos extends Category {
  Videos(String engName, String rusName, IconData iconData,
      int allQuestionsNumber, bool isChecked)
      : super(engName, rusName, iconData, allQuestionsNumber, isChecked);
}

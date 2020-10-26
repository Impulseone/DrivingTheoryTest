import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesProvider {
  List<Category> generateCategoriesInfo() {
    List<Category> categories = List();
    categories.add(AllCategories(
        "All categories", 'Все категории', Icons.list, 757, false));
    categories
        .add(Alertness("Alertness", 'Осторожность', Icons.vpn_key, 26, false));
    categories
        .add(Attitude("Attitude", 'Положение', Icons.tag_faces, 39, false));
    categories.add(Documents(
        "Documents", 'Документы', Icons.library_books_sharp, 28, false));
    categories.add(HazardAwareness(
        "Hazard awareness",
        'Осведомленность об опасности',
        Icons.warning_amber_outlined,
        78,
        false));
    categories.add(RoadAndTrafficSigns("Road and traffic signs",
        'Дорога и дорожные знаки', Icons.traffic, 133, false));
    categories.add(Incidents(
        "Incidents, accidents and emergencies",
        'Происшествия, аварии и чрезвычайные ситуации',
        Icons.medical_services,
        48,
        false));
    categories.add(OtherTypesOfVehicle("Other types of vehicle",
        'Другие виды транспорта', Icons.bus_alert, 22, false));
    categories.add(VehicleHandling("Vehicle handling", 'Управление автомобилем',
        Icons.directions_car, 44, false));
    categories.add(MotorwayRules(
        "Motorway rules", 'Правила автомагистрали', Icons.add_road, 55, false));
    categories.add(RulesOfTheRoad(
        "Rules of the road", 'Правила дороги', Icons.note_outlined, 67, false));
    categories.add(SafetyMargins(
        "Safety margins", 'Запас прочности', Icons.speed, 33, false));
    categories.add(SafetyAndVehicle("Safety and your vehicle",
        'Безопасность и ваш автомобиль', Icons.build, 78, false));
    categories.add(VulnerableRoadUsers("Vulnerable road users",
        'Уязвимые участники дорожного движения', Icons.people, 67, false));
    categories.add(VehicleLoading(
        "Vehicle loading", 'Загрузка автомобиля', Icons.car_rental, 12, false));
    categories
        .add(Videos("Videos", 'Видео', Icons.video_collection, 27, false));
    return categories;
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

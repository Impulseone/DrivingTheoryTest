import 'package:dirving_theory_test/bloc/questionBloc.dart';
import 'package:dirving_theory_test/view/question_screen.dart';
import 'package:dirving_theory_test/view/settings_page.dart';
import 'package:flutter/material.dart';

class CategoriesToPracticeScreen extends StatefulWidget {
  @override
  _CategoriesToPracticeScreenState createState() =>
      _CategoriesToPracticeScreenState();
}

class _CategoriesToPracticeScreenState
    extends State<CategoriesToPracticeScreen> {
  QuestionBloc questionBloc = QuestionBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Categories to practice \n0 of 757 selected"),
        ),
        body: ListView(
          children: [
            Card(
              child: Text("All categories\nВсе категории"),
            ),
            Card(
              child: Text("Alertness\nОсторожность"),
            ),
            Card(
              child: Text("Attitude \nПоложение"),
            ),
            Card(
              child: Text("Documents \nДокументы"),
            ),
            Card(
              child: Text("Hazard awareness\nОсведомленность об опасности"),
            ),
            Card(
              child: Text("Road and traffic signs \nДорога и дорожные знаки"),
            ),
            Card(
              child: Text(
                  "Incidents, accidents and emergencies \nПроисшествия, аварии и чрезвычайные ситуации"),
            ),
            Card(
              child: Text("Other types of vehicle \nДругие типы автомобилей"),
            ),
            Card(
              child: Text("Vehicle handling \nУправление автомобилем"),
            ),
            Card(
              child: Text("Motorway rules \nПравила автомагистрали"),
            ),
            Card(
              child: Text("Safety margins \nПравила безопасности"),
            ),
            Card(
              child: Text(
                  "Safety and your vehicle \nБезопасность и ваш автомобиль"),
            ),
            Card(
              child: Text(
                  "Vulnerable road users \nУязвимые участники дорожного движения"),
            ),
            Card(
              child: Text("Vehicle loading \nЗагрузка автомобиля"),
            ),
            Card(
              child: Text("Videos \nВидео"),
            ),
          ],
        ),
        floatingActionButton: Container(
            width: 600,
            height: 30.0,
            child: new RaisedButton(
              elevation: 0.0,
              color: Colors.green,
              child: Text("Start"),
              onPressed: () {
                questionBloc.readQuestionsFromFile();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QuestionScreen(questionBloc)));
              },
            )));
  }
}

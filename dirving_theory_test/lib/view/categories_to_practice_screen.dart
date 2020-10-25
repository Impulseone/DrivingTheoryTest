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
  int selectedCategories = 0;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Categories to practice \n$selectedCategories of 757 selected"),
        backgroundColor: Colors.black,
      ),
      body: categoriesList(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.green,
          child: Container(
              child: new RaisedButton(
            elevation: 0.0,
            color: Colors.green,
            child: Text(
              "START",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            onPressed: () {
              questionBloc.readQuestionsFromFile();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuestionScreen(questionBloc)));
            },
          ))),
    );
  }

  Widget categoriesList() {
    return ListView(
      children: [
        categoryWidget('All categories\nВсе категории', Icons.list),
        categoryWidget('Alertness\nОсторожность', Icons.vpn_key),
        categoryWidget('Attitude \nПоложение', Icons.tag_faces),
        categoryWidget('Documents \nДокументы', Icons.library_books_sharp),
        categoryWidget('Hazard awareness\nОсведомленность об опасности',
            Icons.warning_amber_outlined),
        categoryWidget(
            'Road and traffic signs \nДорога и дорожные знаки', Icons.traffic),
        categoryWidget(
            'Incidents, accidents and emergencies \nПроисшествия, аварии и чрезвычайные ситуации',
            Icons.medical_services),
        categoryWidget(
            'Other types of vehicle \nДругие виды транспорта', Icons.bus_alert),
        categoryWidget(
            'Vehicle handling \nУправление автомобилем', Icons.directions_car),
        categoryWidget(
            'Motorway rules \nПравила автомагистрали', Icons.add_road),
        categoryWidget('Safety margins \nПравила безопасности', Icons.speed),
        categoryWidget(
            'Safety and your vehicle \nБезопасность и ваш автомобиль',
            Icons.build),
        categoryWidget(
            'Vulnerable road users \nУязвимые участники дорожного движения',
            Icons.people),
        categoryWidget(
            'Vehicle loading \nЗагрузка автомобиля', Icons.car_rental),
        categoryWidget('Videos \nВидео', Icons.video_collection),
      ],
    );
  }

  Widget categoryWidget(String text, IconData iconData) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              iconData,
              size: 45,
              color: Colors.green,
            ),
            Container(
              child: Text(
                text,
              ),
              width: 270,
              padding: EdgeInsets.only(left: 10),
            ),
            Checkbox(
              onChanged: (isChecked) {
                setState(() {
                  if (isChecked)
                    selectedCategories = 757;
                  else
                    selectedCategories = 0;
                  this.isChecked = isChecked;
                });
              },
              value: isChecked,
              activeColor: Colors.green,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Container(
          height: 2,
          width: double.infinity,
          color: Colors.green,
        )
      ],
    );
  }
}

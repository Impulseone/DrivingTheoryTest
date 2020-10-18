import 'package:dirving_theory_test/view/categories_to_practice_screen.dart';
import 'package:flutter/material.dart';

class TheoryTestMenuPage extends StatefulWidget {
  @override
  _TheoryTestMenuPageState createState() => _TheoryTestMenuPageState();
}

class _TheoryTestMenuPageState extends State<TheoryTestMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Driving Test")),
      body: ListView(
        children: [
          RaisedButton(
              child: Text('Practice all questions \n Все вопросы '),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoriesToPracticeScreen()));
              }),
          RaisedButton(
              child: Text('Mock test \n Пробный тест '), onPressed: () {}),
          RaisedButton(
              child: Text('Search questions \n Поиск вопросов '),
              onPressed: () {}),
          RaisedButton(
              child: Text('My questions \n Мои вопросы '), onPressed: () {}),
          RaisedButton(
              child: Text('Progress monitor \n Индикатор прогресса '),
              onPressed: () {}),
          RaisedButton(
              child: Text('Stopping distances \n Тормозные пути '),
              onPressed: () {}),
          RaisedButton(
              child: Text('Help & Support \n Помощь и поддержка '),
              onPressed: () {}),
          RaisedButton(
              child: Text('Offers and Rewards \n Предложения и награды '),
              onPressed: () {}),
        ],
      ),
    );
  }
}

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
      appBar: AppBar(title: Text("Theory Test")),
      body: Column(
        children: [
          RaisedButton(
              color: Colors.green,
              child: Text(
                "Practice all questions\nПрактиковать все вопросы",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoriesToPracticeScreen()));
              }),
          RaisedButton(
            color: Colors.green,
            child: Text("Mock test \nПробный тест",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                )),
            onPressed: () {},
          ),
          RaisedButton(
              color: Colors.green,
              child: Text(
                "Search questions \nПоиск вопросов",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () {}),
          RaisedButton(
              color: Colors.green,
              child: Text(
                "My questions\nМои вопросы",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () {}),
          RaisedButton(
              color: Colors.green,
              child: Text(
                "Progress monitor\nИндикатор прогресса",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () {}),
          RaisedButton(
              color: Colors.green,
              child: Text(
                "Stopping distances \n Тормозные пути",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () {}),
          RaisedButton(
              color: Colors.green,
              child: Text(
                "Help & Support \n Помощь и поддержка",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () {}),
          RaisedButton(
              color: Colors.green,
              child: Text(
                "Offers and Rewards \n Предложения и награды",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () {}),
        ],
      ),
    );
  }
}

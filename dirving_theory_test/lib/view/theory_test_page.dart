import 'package:dirving_theory_test/bloc/categories_bloc.dart';
import 'package:dirving_theory_test/view/categories_to_practice_screen.dart';
import 'package:flutter/material.dart';

class TheoryTestMenuPage extends StatefulWidget {
  @override
  _TheoryTestMenuPageState createState() => _TheoryTestMenuPageState();
}

class _TheoryTestMenuPageState extends State<TheoryTestMenuPage> {

  CategoriesBloc categoriesBloc = new CategoriesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Driving Test"),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Container(
              child: Text(
                "THEORY TEST\n"
                "ТЕСТ ПО ТЕОРИИ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              color: Colors.green,
              width: double.infinity,
            ),
            Padding(padding: EdgeInsets.only(top: 18)),
            button("Practice all questions\nПрактиковать все вопросы",
                Icons.arrow_right),
            button("Mock test \nПробный тест", Icons.timer),
            button("Search questions \nПоиск вопросов", Icons.search),
            button("My questions\nМои вопросы", Icons.favorite),
            button("Progress monitor\nИндикатор прогресса", Icons.graphic_eq),
            button("Stopping distances \nТормозные пути",
                Icons.arrow_right_alt_outlined),
            button("Help & Support \nПомощь и поддержка", Icons.mail_outline),
            button("Offers and Rewards \nПредложения и награды", Icons.star),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar());
  }

  Widget button(String text, IconData iconData) {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: SizedBox(
          width: 300.0,
          child: RaisedButton(
              elevation: 0,
              color: Colors.green,
              child: Row(
                children: [
                  Container(
                    width: 215,
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(iconData, color: Colors.white, size: 50)
                ],
              ),
              onPressed: () {
                categoriesBloc.readAnsweredQuestions();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoriesToPracticeScreen(categoriesBloc)));
              }),
        ));
  }

  Widget bottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
          primaryColor: Colors.white,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.white))),
      child: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (tappedIcon) {
          print(tappedIcon);
        },
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.info_outline,
              size: 30,
            ),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.settings,
              size: 30,
            ),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.star_border,
              size: 30,
            ),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.share,
              size: 30,
            ),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.shop, size: 30),
            label: "",
          )
        ],
      ),
    );
  }
}

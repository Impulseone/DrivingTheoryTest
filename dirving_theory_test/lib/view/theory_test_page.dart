import 'package:dirving_theory_test/bloc/categories_bloc.dart';
import 'package:dirving_theory_test/extension/categories_provider.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
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
              child: Column(
                children: [
                  Text(
                    "THEORY TEST",
                    style: CustomTextStyle.engTextStyleHeadline(context),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "ТЕСТ ПО ТЕОРИИ",
                    style: CustomTextStyle.rusTextStyleHeadline(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              color: Colors.green,
              width: double.infinity,
            ),
            Padding(padding: EdgeInsets.only(top: 18)),
            button("Practice all questions", "Практиковать все вопросы",
                Icons.arrow_right),
            button("Mock test", "Пробный тест", Icons.timer),
            button("Search questions", "Поиск вопросов", Icons.search),
            button("My questions", "Мои вопросы", Icons.favorite),
            button("Progress monitor", "Индикатор прогресса", Icons.graphic_eq),
            button("Stopping distances", "Тормозные пути",
                Icons.arrow_right_alt_outlined),
            button("Help & Support", "Помощь и поддержка", Icons.mail_outline),
            button("Offers and Rewards", "Предложения и награды", Icons.star),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar());
  }

  Widget button(String engText, String rusText, IconData iconData) {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          engText,
                          style: CustomTextStyle.engTextStyleBody(context),
                        ),
                        Text(
                          rusText,
                          style: CustomTextStyle.rusTextStyleBody(context),
                        ),
                      ],
                    ),
                  ),
                  Icon(iconData, color: Colors.white, size: 50)
                ],
              ),
              onPressed: () {
                if (engText == "Practice all questions") {
                  categoriesBloc.readAnsweredQuestions();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoriesToPracticeScreen(
                          categoriesBloc,
                          CategoriesProvider().generateCategoriesInfo())));
                }
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

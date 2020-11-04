import 'package:dirving_theory_test/bloc/categories_bloc.dart';
import 'package:dirving_theory_test/extension/categories_provider.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/view/categories_to_practice_screen.dart';
import 'package:dirving_theory_test/view/search_question_screen.dart';
import 'package:flutter/material.dart';

import 'favorite_questions_screen.dart';

enum PageType {
  PRACTICE_ALL_QUESTIONS,
  MOCK_TEST,
  SEARCH_QUESTIONS,
  MY_QUESTIONS,
  PROGRESS_MONITOR,
  STOPPING_DISTANCES,
  HELP_SUPPORT,
  OFFERS_REWARDS
}

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
                Icons.arrow_right, PageType.PRACTICE_ALL_QUESTIONS),
            button(
                "Mock test", "Пробный тест", Icons.timer, PageType.MOCK_TEST),
            button("Search questions", "Поиск вопросов", Icons.search,
                PageType.SEARCH_QUESTIONS),
            button("My questions", "Мои вопросы", Icons.favorite,
                PageType.MY_QUESTIONS),
            button("Progress monitor", "Индикатор прогресса", Icons.graphic_eq,
                PageType.PROGRESS_MONITOR),
            button("Stopping distances", "Тормозные пути",
                Icons.arrow_right_alt_outlined, PageType.STOPPING_DISTANCES),
            button("Help & Support", "Помощь и поддержка", Icons.mail_outline,
                PageType.HELP_SUPPORT),
            button("Offers and Rewards", "Предложения и награды", Icons.star,
                PageType.OFFERS_REWARDS),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar());
  }

  Widget button(
      String engText, String rusText, IconData iconData, PageType pageType) {
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
                switch (pageType) {
                  case PageType.PRACTICE_ALL_QUESTIONS:
                    openCategoriesToPracticePage();
                    return;
                  case PageType.MOCK_TEST:
                    openMockPage();
                    return;
                  case PageType.SEARCH_QUESTIONS:
                    openSearchQuestionsPage();
                    return;
                  case PageType.MY_QUESTIONS:
                    openFavoritesScreen();
                    return;
                  default:
                    return;
                }
              }),
        ));
  }

  void openFavoritesScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FavoriteQuestionsScreen()));
  }

  void openCategoriesToPracticePage() {
    categoriesBloc.readAnsweredQuestions();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CategoriesToPracticeScreen(
            categoriesBloc, CategoriesProvider().generateCategoriesInfo())));
  }

  void openMockPage() {}

  void openSearchQuestionsPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchQuestionScreen()));
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

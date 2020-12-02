import 'package:dirving_theory_test/bloc/answered_questions_bloc.dart';
import 'package:dirving_theory_test/bloc/categories_bloc.dart';
import 'package:dirving_theory_test/extension/categories_provider.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/view/menu_screens/select_category_screen.dart';
import 'package:dirving_theory_test/view/questions_screens/favorite_questions_screen.dart';
import 'package:dirving_theory_test/view/questions_screens/search_question_screen.dart';
import 'package:flutter/material.dart';

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

class SelectOperationMenuPage extends StatefulWidget {
  @override
  _SelectOperationMenuPageState createState() =>
      _SelectOperationMenuPageState();
}

class _SelectOperationMenuPageState extends State<SelectOperationMenuPage> {
  AnsweredQuestionsBloc _answeredQuestionsBloc = new AnsweredQuestionsBloc();
  CategoriesBloc _categoriesBloc = CategoriesBloc();
  List<Category> _categories = List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Driving Test"),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            _header(),
            SizedBox(
              height: 12.0,
            ),
           Expanded(
                child: Container(width: MediaQuery.of(context).size.width * 0.9, child: ListView(
              children: [
                _button("Practice all questions", "Практиковать все вопросы",
                    Icons.arrow_right, PageType.PRACTICE_ALL_QUESTIONS),
                _button("Mock test", "Пробный тест", Icons.timer,
                    PageType.MOCK_TEST),
                _button("Search questions", "Поиск вопросов", Icons.search,
                    PageType.SEARCH_QUESTIONS),
                _button("My questions", "Мои вопросы", Icons.favorite,
                    PageType.MY_QUESTIONS),
                _button("Progress monitor", "Индикатор прогресса",
                    Icons.graphic_eq, PageType.PROGRESS_MONITOR),
                _button(
                    "Stopping distances",
                    "Тормозные пути",
                    Icons.arrow_right_alt_outlined,
                    PageType.STOPPING_DISTANCES),
                _button("Help & Support", "Помощь и поддержка",
                    Icons.mail_outline, PageType.HELP_SUPPORT),
                _button("Offers and Rewards", "Предложения и награды",
                    Icons.star, PageType.OFFERS_REWARDS),
              ],
            )))
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar());
  }

  Widget _header() {
    return Container(
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
    );
  }

  Widget _button(
      String engText, String rusText, IconData iconData, PageType pageType) {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: RaisedButton(
              elevation: 0,
              color: Colors.green,
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: _textInsideButton(engText, rusText)),
                  Icon(iconData, color: Colors.white, size: 40)
                ],
              ),
              onPressed: _openPage(pageType)),
        ));
  }

  Widget _textInsideButton(String engText, String rusText) {
    return Container(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              engText,
              style: CustomTextStyle.engTextStyleMenu(context),
            ),
            Text(
              rusText,
              style: CustomTextStyle.rusTextStyleMenu(context),
            ),
          ],
        ));
  }

  Widget _bottomNavigationBar() {
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
          _bottomNavigationBarItem(Icons.info_outline),
          _bottomNavigationBarItem(Icons.settings),
          _bottomNavigationBarItem(Icons.star_border),
          _bottomNavigationBarItem(Icons.share),
          _bottomNavigationBarItem(Icons.shop),
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(IconData iconData) {
    return new BottomNavigationBarItem(
      icon: new Icon(
        iconData,
        size: 30,
      ),
      label: "",
    );
  }

  Function _openPage(PageType pageType) {
    return () {
      switch (pageType) {
        case PageType.PRACTICE_ALL_QUESTIONS:
          _generateCategories();
          _openCategoriesToPracticePage();
          return;
        case PageType.MOCK_TEST:
          _openMockPage();
          return;
        case PageType.SEARCH_QUESTIONS:
          _openSearchQuestionsPage();
          return;
        case PageType.MY_QUESTIONS:
          _openFavoritesScreen();
          return;
        default:
          return;
      }
    };
  }

  void _generateCategories() async {
    _categories = await _categoriesBloc.generateCategories();
  }

  void _openFavoritesScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FavoriteQuestionsScreen()));
  }

  void _openCategoriesToPracticePage() {
    _answeredQuestionsBloc.readAnsweredQuestions();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SelectCategoryScreen(
            _answeredQuestionsBloc, _categories, _categoriesBloc)));
  }

  void _openMockPage() {}

  void _openSearchQuestionsPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchQuestionScreen()));
  }
}

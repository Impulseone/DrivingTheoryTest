import 'package:dirving_theory_test/bloc/answered_questions_bloc.dart';
import 'package:dirving_theory_test/bloc/categories_bloc.dart';
import 'package:dirving_theory_test/bloc/question_bloc.dart';
import 'package:dirving_theory_test/database/model/answered_question.dart';
import 'package:dirving_theory_test/extension/categories_provider.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:dirving_theory_test/view/questions_screens/question_screen.dart';
import 'package:flutter/material.dart';

class SelectCategoryScreen extends StatefulWidget {
  final AnsweredQuestionsBloc answeredQuestionsBloc;
  final CategoriesBloc categoriesBloc;
  final List<Category> categoriesList;

  SelectCategoryScreen(
      this.answeredQuestionsBloc, this.categoriesList, this.categoriesBloc);

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  QuestionBloc _questionBloc;
  List<Category> _selectedCategoriesList;
  List<Question> _allQuestions;
  int _selectedQuestions;

  @override
  void initState() {
    super.initState();
    _questionBloc = QuestionBloc();
    _selectedCategoriesList = List();
    _allQuestions = List();
    _selectedQuestions = 0;
    _questionBloc.readAllQuestionsFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _questionBloc.allQuestions,
          builder: (ctxt, snap) {
            if (snap.hasData) {
              _allQuestions = (snap.data as List<Question>);
              return Text(
                  "Categories to practice \n$_selectedQuestions of ${(snap.data as List<Question>).length} selected");
            } else
              return Text(
                  "Categories to practice \n$_selectedQuestions of 0 selected");
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: _categoriesList(),
      bottomNavigationBar:
          BottomAppBar(color: Colors.green, child: _startButton()),
    );
  }

  Widget _startButton() {
    return Container(
        child: new RaisedButton(
            elevation: 0.0,
            color: Colors.green,
            child: Text(
              "START",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            onPressed: () => _startQuestionScreen()));
  }

  Widget _categoriesList() {
    return StreamBuilder(
        stream: widget.categoriesBloc.categories,
        builder: (ctx, snap) {
          if (snap.hasData)
            return ListView(
              children: [
                _categoryWidget(_findCategory(snap.data, 'All categories')),
                _categoryWidget(_findCategory(snap.data, 'Alertness')),
                _categoryWidget(_findCategory(snap.data, 'Attitude')),
                _categoryWidget(_findCategory(snap.data, 'Documents')),
                _categoryWidget(_findCategory(snap.data, 'Hazard awareness')),
                _categoryWidget(
                    _findCategory(snap.data, 'Road and traffic signs')),
                _categoryWidget(_findCategory(
                    snap.data, 'Incidents, accidents and emergencies')),
                _categoryWidget(
                    _findCategory(snap.data, 'Other types of vehicle')),
                _categoryWidget(_findCategory(snap.data, 'Vehicle handling')),
                _categoryWidget(_findCategory(snap.data, 'Motorway rules')),
                _categoryWidget(_findCategory(snap.data, 'Rules of the road')),
                _categoryWidget(_findCategory(snap.data, 'Safety margins')),
                _categoryWidget(
                    _findCategory(snap.data, 'Safety and your vehicle')),
                _categoryWidget(
                    _findCategory(snap.data, 'Vulnerable road users')),
                _categoryWidget(_findCategory(snap.data, 'Vehicle loading')),
              ],
            );
          else
            return Container();
        });
  }

  Widget _categoryWidget(Category category) {
    List<AnsweredQuestion> categoryAnsweredQuestionsAll = List();
    List<AnsweredQuestion> categoryAnsweredQuestionsTrue = List();
    return StreamBuilder(
        stream: widget.answeredQuestionsBloc.answeredQuestions,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            (snapshot.data as List<AnsweredQuestion>).forEach((element) {
              _fillAnsweredQuestions(element, category,
                  categoryAnsweredQuestionsAll, categoryAnsweredQuestionsTrue);
            });
            return Column(
              children: [
                Row(
                  children: [
                    Icon(
                      category.iconData,
                      size: 45,
                      color: Colors.green,
                    ),
                    _centerCategoryInfo(
                        category.engName,
                        category.rusName,
                        categoryAnsweredQuestionsAll,
                        categoryAnsweredQuestionsTrue,
                        category.allQuestionsNumber),
                    _checkbox(category.allQuestionsNumber, category),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                _divider()
              ],
            );
          } else
            return Container();
        });
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 2,
      width: double.infinity,
      color: Colors.green,
    );
  }

  Widget _centerCategoryInfo(
      String engText,
      String rusText,
      List<AnsweredQuestion> categoryAnsweredQuestionsAll,
      List<AnsweredQuestion> categoryAnsweredQuestionsTrue,
      int questionsMax) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    engText,
                    style: CustomTextStyle.engTextStyleBodyBlack(context),
                  ),
                  Text(
                    rusText,
                    style: CustomTextStyle.rusTextStyleBodyBlack(context),
                  ),
                ],
              ),
              width: 195,
            ),
            Text(
                "${((categoryAnsweredQuestionsTrue.length / questionsMax) * 100).round()}%")
          ],
        ),
        Row(
          children: [
            Container(
              width: 225,
              height: 10,
              margin: EdgeInsets.only(top: 2, bottom: 2),
              child: LinearProgressIndicator(
                value: categoryAnsweredQuestionsAll.length / questionsMax,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.red,
              ),
            )
          ],
        ),
        Row(
          children: [
            Text(
              "Answered:${categoryAnsweredQuestionsAll.length}/$questionsMax",
              style: CustomTextStyle.rusTextStyleBodyBlack(context),
            ),
            SizedBox(
              width: 65,
            ),
            Text(
                "Correctly:${categoryAnsweredQuestionsTrue.length}/$questionsMax",
                style: CustomTextStyle.rusTextStyleBodyBlack(context))
          ],
        ),
      ],
    );
  }

  Widget _checkbox(int categoriesMax, Category category) {
    return Checkbox(
      onChanged: (isChecked) {
        setState(() {
          if (category.engName == 'All categories') {
            _setAllChecked(widget.categoriesList, isChecked);
            return;
          } else {
            if (isChecked) {
              _selectedCategoriesList.add(category);
              category.isChecked = isChecked;
              _selectedQuestions += categoriesMax;
              if (_checkAllChecked(widget.categoriesList))
                _setAllChecked(widget.categoriesList, true);
            } else {
              _selectedCategoriesList.remove(category);
              _setAllUnchecked(widget.categoriesList);
              _selectedQuestions -= categoriesMax;
              category.isChecked = isChecked;
            }
          }
        });
      },
      value: category.isChecked,
      activeColor: Colors.green,
    );
  }

  void _startQuestionScreen() {
    if (_selectedCategoriesList.length > 0) {
      _questionBloc.getQuestionsForCategories(_selectedCategoriesList);
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => QuestionScreen(_questionBloc)))
          .then((value) => setState(
              () => {widget.answeredQuestionsBloc.readAnsweredQuestions()}));
    }
  }

  void _fillAnsweredQuestions(
      AnsweredQuestion element,
      Category category,
      List<AnsweredQuestion> categoryAnsweredQuestionsAll,
      List<AnsweredQuestion> categoryAnsweredQuestionsTrue) {
    if (element.category == category.engName) {
      categoryAnsweredQuestionsAll.add(element);
      _fillAnsweredQuestionsTrue(categoryAnsweredQuestionsTrue, element);
    }
  }

  void _fillAnsweredQuestionsTrue(
      List<AnsweredQuestion> categoryAnsweredQuestionsTrue,
      AnsweredQuestion element) {
    if (element.answerIsTrue == 1) categoryAnsweredQuestionsTrue.add(element);
  }

  Category _findCategory(List<Category> categories, String categoryName) {
    Category category = categories.first;
    categories.forEach((element) {
      if (element.engName == categoryName) {
        category = element;
      }
    });
    return category;
  }

  bool _checkAllChecked(List<Category> allCategories) {
    bool isAllChecked = true;
    List<Category> categoriesWithoutAll = List();
    categoriesWithoutAll.addAll(allCategories);
    categoriesWithoutAll.remove(_findCategory(allCategories, "All categories"));
    categoriesWithoutAll.forEach((element) {
      if (!element.isChecked) isAllChecked = false;
    });
    return isAllChecked;
  }

  void _setAllUnchecked(List<Category> allCategories) {
    Category category = _findCategory(allCategories, "All categories");
    category.isChecked = false;
  }

  void _setAllChecked(List<Category> allCategories, isChecked) {
    setState(() {
      if (isChecked) {
        _selectedCategoriesList.addAll(allCategories);
        allCategories.forEach((element) {
          element.isChecked = true;
        });
        _selectedQuestions = _allQuestions.length;
      } else {
        _selectedCategoriesList = List();
        _selectedQuestions = 0;
        allCategories.forEach((element) {
          element.isChecked = false;
        });
      }
    });
  }
}

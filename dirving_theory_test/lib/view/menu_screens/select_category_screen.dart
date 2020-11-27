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
  QuestionBloc questionBloc = QuestionBloc();
  List<Category> selectedCategoriesList = List();
  List<Question> allQuestions = List();
  int selectedQuestions = 0;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    questionBloc.readAllQuestionsFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: questionBloc.allQuestions,
          builder: (ctxt, snap) {
            if (snap.hasData) {
              allQuestions = (snap.data as List<Question>);
              return Text(
                  "Categories to practice \n$selectedQuestions of ${(snap.data as List<Question>).length} selected");
            } else
              return Text(
                  "Categories to practice \n$selectedQuestions of 0 selected");
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

  void _startQuestionScreen() {
    if (selectedCategoriesList.length > 0) {
      questionBloc.getQuestionsForCategories(selectedCategoriesList);
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => QuestionScreen(questionBloc)))
          .then((value) => setState(
              () => {widget.answeredQuestionsBloc.readAnsweredQuestions()}));
    }
  }

  Widget _categoriesList() {
    return StreamBuilder(
        stream: widget.categoriesBloc.categories,
        builder: (ctx, snap) {
          if(snap.hasData)
          return ListView(
            children: [
              categoryWidget(findCategory(snap.data, 'All categories')),
              categoryWidget(findCategory(snap.data, 'Alertness')),
              categoryWidget(findCategory(snap.data, 'Attitude')),
              categoryWidget(findCategory(snap.data, 'Documents')),
              categoryWidget(findCategory(snap.data, 'Hazard awareness')),
              categoryWidget(
                  findCategory(snap.data, 'Road and traffic signs')),
              categoryWidget(findCategory(
                  snap.data, 'Incidents, accidents and emergencies')),
              categoryWidget(
                  findCategory(snap.data, 'Other types of vehicle')),
              categoryWidget(findCategory(snap.data, 'Vehicle handling')),
              categoryWidget(findCategory(snap.data, 'Motorway rules')),
              categoryWidget(findCategory(snap.data, 'Rules of the road')),
              categoryWidget(findCategory(snap.data, 'Safety margins')),
              categoryWidget(
                  findCategory(snap.data, 'Safety and your vehicle')),
              categoryWidget(findCategory(snap.data, 'Vulnerable road users')),
              categoryWidget(findCategory(snap.data, 'Vehicle loading')),
            ],
          );
          else return Container();
        });
  }

  Widget categoryWidget(Category category) {
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
                    centerCategoryInfo(
                        category.engName,
                        category.rusName,
                        categoryAnsweredQuestionsAll,
                        categoryAnsweredQuestionsTrue,
                        category.allQuestionsNumber),
                    checkbox(category.allQuestionsNumber, category),
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

  Widget checkbox(int categoriesMax, Category category) {
    return Checkbox(
      onChanged: (isChecked) {
        setState(() {
          if (category.engName == 'All categories') {
            setAllChecked(widget.categoriesList, isChecked);
            return;
          } else {
            if (isChecked) {
              selectedCategoriesList.add(category);
              category.isChecked = isChecked;
              selectedQuestions += categoriesMax;
              if (checkAllChecked(widget.categoriesList))
                setAllChecked(widget.categoriesList, true);
            } else {
              selectedCategoriesList.remove(category);
              setAllUnchecked(widget.categoriesList);
              selectedQuestions -= categoriesMax;
              category.isChecked = isChecked;
            }
          }
        });
      },
      value: category.isChecked,
      activeColor: Colors.green,
    );
  }

  bool checkAllChecked(List<Category> allCategories) {
    bool isAllChecked = true;
    List<Category> categoriesWithoutAll = List();
    categoriesWithoutAll.addAll(allCategories);
    categoriesWithoutAll.remove(findCategory(allCategories, "All categories"));
    categoriesWithoutAll.forEach((element) {
      if (!element.isChecked) isAllChecked = false;
    });
    return isAllChecked;
  }

  void setAllUnchecked(List<Category> allCategories) {
    Category category = findCategory(allCategories, "All categories");
    category.isChecked = false;
  }

  void setAllChecked(List<Category> allCategories, isChecked) {
    setState(() {
      if (isChecked) {
        selectedCategoriesList.addAll(allCategories);
        allCategories.forEach((element) {
          element.isChecked = true;
        });
        selectedQuestions = allQuestions.length;
      } else {
        selectedCategoriesList = List();
        selectedQuestions = 0;
        allCategories.forEach((element) {
          element.isChecked = false;
        });
      }
    });
  }

  Widget centerCategoryInfo(
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
              width: 250,
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
                "${((categoryAnsweredQuestionsTrue.length / questionsMax) * 100).round()}%")
          ],
        ),
        Row(
          children: [
            Container(
              width: 250,
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
              width: 100,
            ),
            Text(
                "Correctly:${categoryAnsweredQuestionsTrue.length}/$questionsMax",
                style: CustomTextStyle.rusTextStyleBodyBlack(context))
          ],
        ),
      ],
    );
  }

  Category findCategory(List<Category> categories, String categoryName) {
    Category category = categories.first;
    categories.forEach((element) {
      if (element.engName == categoryName) {
        category = element;
      }
    });
    return category;
  }
}

import 'package:dirving_theory_test/bloc/categories_bloc.dart';
import 'package:dirving_theory_test/bloc/question_bloc.dart';
import 'package:dirving_theory_test/database/model/answered_question.dart';
import 'package:dirving_theory_test/extension/categories_provider.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/view/question_screen.dart';
import 'package:flutter/material.dart';

class CategoriesToPracticeScreen extends StatefulWidget {
  final CategoriesBloc categoriesBloc;
  final List<Category> categoriesList;

  CategoriesToPracticeScreen(this.categoriesBloc, this.categoriesList);

  @override
  _CategoriesToPracticeScreenState createState() =>
      _CategoriesToPracticeScreenState();
}

class _CategoriesToPracticeScreenState
    extends State<CategoriesToPracticeScreen> {
  QuestionBloc questionBloc = QuestionBloc();
  List<Category> selectedCategoriesList = List();
  int selectedQuestions = 0;
  bool isChecked = false;

  static const int ALL_QUESTIONS_NUMBER = 757;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Categories to practice \n$selectedQuestions of $ALL_QUESTIONS_NUMBER selected"),
        backgroundColor: Colors.black,
      ),
      body: categoriesList(widget.categoriesList),
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
              questionBloc.getQuestionsForCategories(selectedCategoriesList);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuestionScreen(questionBloc)));
            },
          ))),
    );
  }

  Widget categoriesList(List<Category> categories) {
    return ListView(
      children: [
        categoryWidget(findCategory(categories, 'All categories')),
        categoryWidget(findCategory(categories, 'Alertness')),
        categoryWidget(findCategory(categories, 'Attitude')),
        categoryWidget(findCategory(categories, 'Documents')),
        categoryWidget(findCategory(categories, 'Hazard awareness')),
        categoryWidget(findCategory(categories, 'Road and traffic signs')),
        categoryWidget(
            findCategory(categories, 'Incidents, accidents and emergencies')),
        categoryWidget(findCategory(categories, 'Other types of vehicle')),
        categoryWidget(findCategory(categories, 'Vehicle handling')),
        categoryWidget(findCategory(categories, 'Motorway rules')),
        categoryWidget(findCategory(categories, 'Rules of the road')),
        categoryWidget(findCategory(categories, 'Safety margins')),
        categoryWidget(findCategory(categories, 'Safety and your vehicle')),
        categoryWidget(findCategory(categories, 'Vulnerable road users')),
        categoryWidget(findCategory(categories, 'Vehicle loading')),
        categoryWidget(findCategory(categories, 'Videos')),
      ],
    );
  }

  Widget categoryWidget(Category category) {
    return StreamBuilder(
        stream: widget.categoriesBloc.questions,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AnsweredQuestion> categoryAnsweredQuestionsAll = List();
            List<AnsweredQuestion> categoryAnsweredQuestionsTrue = List();
            (snapshot.data as List<AnsweredQuestion>).forEach((element) {
              if (element.category == category.engName) {
                categoryAnsweredQuestionsAll.add(element);
                if (element.answerIsTrue == 1)
                  categoryAnsweredQuestionsTrue.add(element);
              }
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
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  height: 2,
                  width: double.infinity,
                  color: Colors.green,
                )
              ],
            );
          } else
            return Container();
        });
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
        selectedQuestions = 757;
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
                "${((categoryAnsweredQuestionsTrue.length / questionsMax)*100).round()}%")
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
                "Answered:${categoryAnsweredQuestionsAll.length}/$questionsMax", style: CustomTextStyle.rusTextStyleBodyBlack(context),),
            Padding(padding: EdgeInsets.only(left: 60)),
            Text(
                "Correctly:${categoryAnsweredQuestionsTrue.length}/$questionsMax",style: CustomTextStyle.rusTextStyleBodyBlack(context))
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

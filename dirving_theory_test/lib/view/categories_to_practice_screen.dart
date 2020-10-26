import 'package:dirving_theory_test/bloc/categories_bloc.dart';
import 'package:dirving_theory_test/bloc/question_bloc.dart';
import 'package:dirving_theory_test/database/model/answered_question.dart';
import 'package:dirving_theory_test/extension/categories_provider.dart';
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
              questionBloc.readQuestionsFromFile();
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
                        '${category.engName}\n${category.rusName}',
                        categoryAnsweredQuestionsAll,
                        categoryAnsweredQuestionsTrue,
                        category.allQuestionsNumber),
                    checkbox(category.allQuestionsNumber, category),
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
              category.isChecked = isChecked;
              selectedCategories += categoriesMax;
              if (checkAllChecked(widget.categoriesList))
                setAllChecked(widget.categoriesList, true);
            } else {
              setAllUnchecked(widget.categoriesList);
              selectedCategories -= categoriesMax;
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
        allCategories.forEach((element) {
          element.isChecked = true;
        });
        selectedCategories = 757;
      } else {
        selectedCategories = 0;
        allCategories.forEach((element) {
          element.isChecked = false;
        });
      }
    });
  }

  Widget centerCategoryInfo(
      String text,
      List<AnsweredQuestion> categoryAnsweredQuestionsAll,
      List<AnsweredQuestion> categoryAnsweredQuestionsTrue,
      int categoriesMax) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: Text(
                text,
              ),
              width: 250,
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
                "${(categoryAnsweredQuestionsTrue.length / categoriesMax).round() * 100}%")
          ],
        ),
        Row(
          children: [
            Container(
              width: 250,
              child: LinearProgressIndicator(
                value: 0,
                backgroundColor: Colors.red,
              ),
            )
          ],
        ),
        Row(
          children: [
            Text(
                "Answered:${categoryAnsweredQuestionsAll.length}/$categoriesMax"),
            Padding(padding: EdgeInsets.only(left: 30)),
            Text(
                "Correctly:${categoryAnsweredQuestionsTrue.length}/$categoriesMax")
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

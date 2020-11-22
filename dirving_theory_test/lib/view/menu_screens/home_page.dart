import 'package:dirving_theory_test/bloc/question_bloc.dart';
import 'package:dirving_theory_test/database/database.dart';
import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:dirving_theory_test/model/question.dart';
import 'package:flutter/material.dart';

import 'select_operation_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    initAndWriteQuestionsToDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Driving Test"),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              menuButton(Colors.green, Icons.menu_book, "THEORY TEST",
                  "ТЕСТ ПО ТЕОРИИ"),
              menuButton(Colors.red, Icons.warning_amber_outlined,
                  "HAZARD PERCEPTION", "ВОСПРИЯТИЕ ОПАСНОСТИ"),
              menuButton(Colors.lightBlue, Icons.list_alt, "HIGHWAY CODE",
                  "ПРАВИЛА ДОРОЖНОГО ДВИЖЕНИЯ"),
              menuButton(Colors.orange, Icons.edit_road, "ROAD SIGNS",
                  "ДОРОЖНЫЕ ЗНАКИ"),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar());
  }

  Widget bottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
          primaryColor: Colors.white,
          textTheme: Theme
              .of(context)
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
          bottomMenuItem(Icons.settings),
          bottomMenuItem(Icons.camera_alt),
          bottomMenuItem(Icons.more),
          bottomMenuItem(Icons.shop),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomMenuItem(IconData iconData){
   return new BottomNavigationBarItem(
      icon: new Icon(
        iconData,
        size: 30,
      ),
      label: "",
    );
  }

  Widget menuButton(Color color, IconData icon, String engText,
      String rusText) {
    return RaisedButton(
      color: color,
      child: Column(
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.white,
          ),
          Text("$engText",
              textAlign: TextAlign.center,
              style: CustomTextStyle.engTextStyleBody(context)),
          Padding(padding: EdgeInsets.all(4)),
          Text("$rusText",
              textAlign: TextAlign.center,
              style: CustomTextStyle.rusTextStyleBody(context))
        ],
      ),
      onPressed: () {
        if (engText == "THEORY TEST")
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SelectOperationMenuPage()));
      },
    );
  }

  void initAndWriteQuestionsToDb() async {
    List<Question> questions = await QuestionBloc().readQuestionsFromFile();
    questions.forEach((element) {
      DBProvider.db.insertQuestion(element);
    });
  }
}
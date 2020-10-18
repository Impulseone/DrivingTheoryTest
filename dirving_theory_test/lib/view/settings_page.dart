import 'package:dirving_theory_test/view/warning_screen.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("I want to revise...\n"),
          Text("Question Bank"),
          RaisedButton(child: Text("Car Driver in GB"), onPressed: () {}),
          Text("Number of Questions"),
          RaisedButton(child: Text("All Questions"), onPressed: () {}),
          Text("Question Type"),
          RaisedButton(child: Text("All Questions"), onPressed: () {}),
          RaisedButton(
              child: Text("Auto move to next question"), onPressed: () {}),
          RaisedButton(
              child: Text("Alert if answer is incorrect"), onPressed: () {}),
          RaisedButton(
              child: Text("Get Started"),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WarningScreen()));
              }),
        ],
      ),
    );
  }
}

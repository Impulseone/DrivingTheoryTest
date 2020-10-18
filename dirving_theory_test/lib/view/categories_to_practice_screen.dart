import 'package:dirving_theory_test/view/settings_page.dart';
import 'package:flutter/material.dart';

class CategoriesToPracticeScreen extends StatefulWidget {
  @override
  _CategoriesToPracticeScreenState createState() =>
      _CategoriesToPracticeScreenState();
}

class _CategoriesToPracticeScreenState
    extends State<CategoriesToPracticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories to practice \n 0 of 757 selected"),
      ),
      body: ListView(
        children: [
          Card(
            child: Text("All categories \n Все категории"),
          ),
          Card(
            child: Text("Alertness \n Все категории"),
          ),
          Card(
            child: Text("Attitude \n Все категории"),
          ),
          Card(
            child: Text("Documents \n Все категории"),
          ),
          Card(
            child: Text("Hazard awareness \n Все категории"),
          ),
          Card(
            child: Text("Road and traffic signs \n Все категории"),
          ),
          Card(
            child:
                Text("Incidents, accidents and emergencies \n Все категории"),
          ),
          Card(
            child: Text("Other types of vehicle \n Все категории"),
          ),
          Card(
            child: Text("Vehicle handling \n Все категории"),
          ),
          Card(
            child: Text("Motorway rules \n Все категории"),
          ),
          Card(
            child: Text("Safety margins \n Все категории"),
          ),
          Card(
            child: Text("Safety and your vehicle \n Все категории"),
          ),
          Card(
            child: Text("Vulnerable road users \n Все категории"),
          ),
          Card(
            child: Text("Vehicle loading \n Все категории"),
          ),
          Card(
            child: Text("Videos \n Все категории"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SettingsPage()));
        },
        backgroundColor: Colors.green,
      ),
    );
  }
}

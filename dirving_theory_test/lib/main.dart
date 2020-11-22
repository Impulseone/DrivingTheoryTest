import 'package:dirving_theory_test/view/menu_screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DrivingTheoryTestHomeScreen());
}

class DrivingTheoryTestHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driving Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

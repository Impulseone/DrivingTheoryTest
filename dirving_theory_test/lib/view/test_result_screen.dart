import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: appBarTitle()),
      body: Container(),
    );
  }
  Widget appBarTitle() {
    return Text("Test Results", style: CustomTextStyle.rusTextStyleBody(context),);
  }
}

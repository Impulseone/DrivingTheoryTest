import 'package:dirving_theory_test/extension/custom_text_style.dart';
import 'package:flutter/material.dart';

class QuestionInfoScreen extends StatelessWidget {
  final String text;

  QuestionInfoScreen(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("Explanation"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    text.split("\n")[0],
                    style: CustomTextStyle.engTextStyleBodyBlack(context),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    text.split("\n")[1],
                    style: CustomTextStyle.rusTextStyleBodyBlack(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
                width: 200.0,
                height: 40,
                child: RaisedButton(
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    color: Colors.green,
                    onPressed: () => Navigator.pop(context)))
          ],
        ));
  }
}

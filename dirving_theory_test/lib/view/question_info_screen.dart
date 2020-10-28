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
            Container(
              padding: EdgeInsets.all(20),
              child: Text(text),
              height: MediaQuery.of(context).size.height / 3,
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

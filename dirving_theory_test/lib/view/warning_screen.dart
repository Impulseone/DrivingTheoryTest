import 'package:flutter/material.dart';

class WarningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Your Theory \n Test Revision"),
          Text(
              "Your practice session has now started. Read the DVSA revision question carefully and choose one answer from the four options below. Be sure to read the official DVSA explanations for help and guidance."),
          RaisedButton(
              child: Text("Continue"), color: Colors.green, onPressed: () {}),
          RaisedButton(
              child: Text("Don't show again"),
              color: Colors.green,
              onPressed: () {})
        ],
      ),
    );
  }
}

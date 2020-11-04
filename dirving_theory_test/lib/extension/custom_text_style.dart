import 'package:flutter/material.dart';

class CustomTextStyle {

  static TextStyle engTextStyleHeadline(BuildContext context) {
    return Theme.of(context).textTheme.headline1.copyWith(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white);
  }
  static TextStyle rusTextStyleHeadline(BuildContext context) {
    return Theme.of(context).textTheme.headline1.copyWith(fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white);
  }
  static TextStyle engTextStyleBody(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white);
  }
  static TextStyle rusTextStyleBody(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 10.0, color: Colors.white);
  }
  static TextStyle engTextStyleBodyBlack(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black);
  }
  static TextStyle rusTextStyleBodyBlack(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 10.0, color: Colors.black);
  }
}
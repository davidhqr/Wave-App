import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Utils {
  static showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }

  static String generateCode() {
    return "wv" + randomAlphaNumeric(8);
  }
}
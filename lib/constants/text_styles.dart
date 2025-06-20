import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle customFont({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
    TextOverflow? overflow,
    double? decorationThickness,
    Color? decorationColor,
    double? height,
  }) {
    return TextStyle(
        decorationThickness: decorationThickness,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        overflow: overflow,
        height: height,
        fontFamily: 'Manrope',
        decorationColor: decorationColor,
        decoration: decoration);
  }

  static TextStyle textFieldStyle = TextStyles.customFont(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle floatingLabelStyle = TextStyles.customFont(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle labelStyle = TextStyles.customFont(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle activeLabelStyle = TextStyles.customFont(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle hintStyle = TextStyles.customFont(
    color: Colors.black26,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle actionPaneStyle =
      TextStyles.customFont(height: 1, color: Colors.white);
}

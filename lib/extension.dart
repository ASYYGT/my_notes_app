// ignore_for_file: file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;
  double get width => MediaQuery.of(this).size.width;
}

extension NumberExtension on BuildContext {
  double get widthPaddingValue => dynamicWidth(0.001);
  double get heigthPaddingValue => dynamicHeight(0.0005);
}

extension AutoTextExtension on BuildContext {
  AutoSizeText lowAutoText(String val, Color color, int maxline) =>
      AutoSizeText(
        val,
        style: TextStyle(color: color),
        maxLines: maxline,
        overflow: TextOverflow.ellipsis,
        minFontSize: 16,
      );
  AutoSizeText middleAutoText(String val, Color color) => AutoSizeText(
        val,
        style: TextStyle(color: color),
        minFontSize: 18,
      );
  AutoSizeText middleTitleAutoText(String val, Color color) => AutoSizeText(
        val,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
        minFontSize: 18,
      );
  AutoSizeText largAutoText(String val, Color color) => AutoSizeText(
        val,
        textAlign: TextAlign.center,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
        minFontSize: 20,
      );
}

extension PaddingExtension on BuildContext {
  EdgeInsets get screenPadding => EdgeInsets.symmetric(
      vertical: heigthPaddingValue, horizontal: widthPaddingValue);
  EdgeInsets dynamicHorizontalPadding(double val) =>
      EdgeInsets.symmetric(horizontal: dynamicWidth(val));
  EdgeInsets dynamicVerticalPadding(double val) =>
      EdgeInsets.symmetric(vertical: dynamicHeight(val));
  EdgeInsets dynamicAllPadding(double val0, double val1) =>
      EdgeInsets.symmetric(
          vertical: dynamicHeight(val0), horizontal: dynamicWidth(val1));
}

extension BorderRadiusExtension on BuildContext {
  BorderRadius get borderRadiusValue =>
      const BorderRadius.all(Radius.circular(15));
}

extension ColorExtension on BuildContext {
  Color get appBarColor => const Color(0xFF2660A4);
  Color get screenBGColor => const Color(0xFFEDF7F6);
  Color get borderColor => const Color(0xFFF19953);
  Color get buttomColor => const Color(0xFFC47335);
  Color get textColor => const Color(0xFF56351E);
}

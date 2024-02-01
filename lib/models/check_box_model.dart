import 'package:flutter/material.dart';

class CustomCheckBoxModel {
  int? id;
  Color? boxColor;
  Color? borderColor;
  bool? isActive;
  String? name;
  CustomCheckBoxModel(
      {this.id, this.borderColor, this.boxColor, this.isActive, this.name});
}

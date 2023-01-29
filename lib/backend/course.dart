import 'package:flutter/material.dart';

class Course {
  String nickname;
  String code;
  Color color;
  bool ntnu;

  Course(this.nickname, this.code, this.color, this.ntnu);

  static Course clone(Course empty) {
    return Course(empty.nickname, empty.code, empty.color, empty.ntnu);
  }
}

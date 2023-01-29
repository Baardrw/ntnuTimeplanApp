import 'package:flutter/material.dart';
import 'package:ntnu_timeplan/backend/course.dart';

class Time {
  // Adding anything in time must be updated in database.dart
  final int start;
  final bool dub;
  final Course course;
  // This is variable is only here to force setstate to repaint the scene
  int i = 0;

  Time(
    this.start,
    this.dub,
    this.course,
  );

  String getStartTime() {
    return "$start:15";
  }

  String getOrdinaryEndTime() {
    if (dub) return "${start + 2}:00";
    return "${start + 1}:00";
  }

  double getHeight(BuildContext context) {
    if (dub) return MediaQuery.of(context).size.height * (1 / 6);
    return MediaQuery.of(context).size.height * (1 / 12);
  }

  Card getCard(BuildContext context) {
    if (dub) return _fullSize(context);
    return _halfSize(context);
  }

  Card _fullSize(BuildContext context) {
    return Card(
      color: course.color,
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getStartTime()),
              Text(course.nickname.isNotEmpty ? "PlaceHolder" : "")
            ],
          ),
          Container(
            padding: const EdgeInsets.all(13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.nickname,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  course.code,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          Text(getOrdinaryEndTime()),
        ],
      ),
    );
  }

  Card _halfSize(BuildContext context) {
    return Card(
        color: course.color,
        elevation: 5,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getStartTime()),
              Padding(
                padding: const EdgeInsets.all(13),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        course.nickname,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(width: 30),
                      Text(
                        course.code,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(width: 30),
                      Text(course.nickname.isNotEmpty ? "PlaceHolder" : "")
                    ],
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(getOrdinaryEndTime()),
              ),
            ],
          ),
        ));
  }
}

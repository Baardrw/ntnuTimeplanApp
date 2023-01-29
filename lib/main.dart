import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ntnu_timeplan/backend/course.dart';
import 'package:ntnu_timeplan/backend/mockerdb.dart';
import 'package:ntnu_timeplan/backend/time.dart';
import 'package:ntnu_timeplan/widgets/timetable.dart';
import 'widgets/timeslot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // TODO : add cool font for title
          textTheme: const TextTheme(
              headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              headline5: TextStyle(fontSize: 12, color: Colors.blueGrey)),
          primarySwatch: Colors.teal,
          backgroundColor: Colors.blueGrey),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MockerDb _db = MockerDb();
  final Course _empty = Course("", "", Colors.white, false);
  final controller = PageController(initialPage: 0);
  String day = 'Monday';

  final List<String> daysList = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  // This missing times constructor is if there is no half times
  List<Time> _constructMissingTimes(List<Time> t) {
    List<int> times = t.map((e) => e.start).toList();
    int i = 8;
    for (i; i <= 16; i += 2) {
      if (times.contains(i)) {
        continue;
      } else if (times.contains(i - 1)) {
        // Anomaly encountered
        i -= 1;
        continue;
      }

      t.add(Time(i, true, Course.clone(_empty)));
    }
    if (i == 17 && !times.contains(17)) {
      t.add(Time(i, false, Course.clone(_empty)));
    }

    t.sort((a, b) => a.start.compareTo(b.start));

    return t;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 177, 192, 199),
      appBar: AppBar(
        title: Text(day),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (value) {
          setState(() {
            day = daysList[value];
          });
        },
        children: [
          Center(child: TimeTable(_constructMissingTimes(_db.monday))),
          Center(child: TimeTable(_constructMissingTimes(_db.tuesday))),
          Center(child: TimeTable(_constructMissingTimes(_db.wednesday))),
          Center(child: TimeTable(_constructMissingTimes(_db.thursday))),
          Center(child: TimeTable(_constructMissingTimes(_db.friday))),
        ],
      ),
    );
  }
}

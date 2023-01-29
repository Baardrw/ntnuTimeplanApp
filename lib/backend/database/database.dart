import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../time.dart';

// Put on hold to create a hardcoded gui mvp
// TODO: Implement database for timeslots
// TODO: Implement database for custom timeslots
// TODO: Implement colors for timeslots
class DataManager {
  Future<Database> startDBMS() async {
    WidgetsFlutterBinding.ensureInitialized();
    Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'database.db'));
    return database;
  }

  // Creates a table for time, only called once
  void createTimeTable() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: ((db, version) {
        // ID is the day integer appended to the front of the start integer
        // eg. day: 1, start 16 ID 116
        return db.execute(
            'CREATE TABLE timeslots(id INTEGER PRIMARY KEY, start INTEGER, dub INTEGER, nickname TEXT, code TEXT, color)');
      }),
    );
  }
}

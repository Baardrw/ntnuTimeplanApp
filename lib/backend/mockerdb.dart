import 'package:flutter/material.dart';
import 'package:ntnu_timeplan/backend/course.dart';
import 'package:ntnu_timeplan/backend/time.dart';

class MockerDb {
  final Course ktn =
      Course("KTN", "TTM4100", Color.fromARGB(255, 195, 249, 190), true);

  final Course os =
      Course("OS", "TDT4186", Color.fromARGB(255, 231, 170, 190), true);

  final Course datBas =
      Course("DatBas", "TDT4145", Color.fromARGB(255, 184, 193, 219), true);

  final Course pu =
      Course("Pu", "TDT4140", Color.fromARGB(255, 231, 199, 152), true);

  late List<Time> monday;
  late List<Time> tuesday;
  late List<Time> wednesday;
  late List<Time> thursday;
  late List<Time> friday;

  MockerDb() {
    monday = [Time(12, true, ktn), Time(14, false, os), Time(15, true, datBas)];
    tuesday = [Time(8, true, datBas), Time(16, true, ktn)];
    wednesday = [Time(10, true, datBas)];

    // TODO : support collisions
    thursday = [Time(8, true, pu), Time(10, true, pu), Time(12, true, os)];
    friday = [Time(8, true, pu), Time(10, true, ktn), Time(14, true, ktn)];
  }
}

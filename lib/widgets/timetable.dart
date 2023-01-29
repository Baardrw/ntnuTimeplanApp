import 'package:flutter/widgets.dart';
import 'package:ntnu_timeplan/backend/time.dart';
import 'package:ntnu_timeplan/widgets/timeslot.dart';

class TimeTable extends StatelessWidget {
  final List<Time> timetable;
  const TimeTable(this.timetable, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: timetable.map((e) => Timeslot(e)).toList(),
    );
  }
}

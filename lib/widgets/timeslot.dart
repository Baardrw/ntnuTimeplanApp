import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ntnu_timeplan/widgets/%20customtask.dart';
import 'package:animations/animations.dart';

import '../backend/time.dart';

class Timeslot extends StatefulWidget {
  final Time _time;
  const Timeslot(this._time, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Timeslot> createState() => _TimeslotState(_time);
}

class _TimeslotState extends State<Timeslot> {
  final Time _time;
  _TimeslotState(this._time);

  late Card card;

  @override
  Widget build(BuildContext context) {
    card = _time.getCard(context);

    return GestureDetector(
      onLongPress: () async {
        final _ = await Navigator.push(context, _createRoute());
        setState(() {
          card = _time.getCard(context);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        height: _time.getHeight(context),
        child: card,
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
      return CustomTask(_time);
    }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.scaled,
        child: child,
      );
    });
  }
}

// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ntnu_timeplan/backend/time.dart';
import 'dart:async';

class CustomTask extends StatefulWidget {
  const CustomTask(this.time, {super.key});

  @override
  State<CustomTask> createState() => _CustomTaskState();

  final Time time;
}

class _CustomTaskState extends State<CustomTask> {
  Color pickerColor = Colors.white;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  // ignore: duplicate_ignore
  Padding getTextFeild(String text, TextEditingController controller) {
    // ignore: prefer_const_constructors
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: text,
            ),
          ),
        ),
      ),
    );
  }

  void changeColor(Color c, setState) {
    setState(() {
      pickerColor = c;
    });
    print("Color Changed");
  }

  Future<void> _colorPicker(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: Text('Color Picker'),
              content: SingleChildScrollView(
                child: MaterialPicker(
                  pickerColor: pickerColor,
                  onColorChanged: (c) => changeColor(c, setState),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(pickerColor)),
                  child: Text(
                    'Set Color',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            );
          }));
        });
  }

  void taskCreated() {
    if (widget.time.course.ntnu) {
      Navigator.of(context).pop();
      return;
    }

    Time time = widget.time;
    time.course.nickname = nameController.text;
    time.course.code = descriptionController.text;
    time.course.color = pickerColor;

    Navigator.of(context).pop();
  }

  // TODO: add functionality for reccuring or one time tasks
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Task'),
      ),
      // TODO : find out why colour is so much darker here
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextFeild('Task Name', nameController),
            SizedBox(height: 5),
            getTextFeild('Description (Optional)', descriptionController),
            SizedBox(height: 5),
            getTextFeild('Room (Optional)', roomController),
            SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () => _colorPicker(context),
                  child: Text('Pick Color'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () => taskCreated(),
                  child: Text('Done'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

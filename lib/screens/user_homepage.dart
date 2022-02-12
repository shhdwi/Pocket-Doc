import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/date_item.dart';
import 'package:horizontal_center_date_picker/date_item_state.dart';
import 'package:horizontal_center_date_picker/date_item_widget.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    DateTime startDate = now.subtract(const Duration(days: 14));
    DateTime endDate = now.add(const Duration(days: 7));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xff221f2c),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child:Text(
                  "Hi, how is your health today ?",
                  textScaleFactor: 4,
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: HorizontalDatePickerWidget(
                startDate: startDate,
                endDate: endDate,
                selectedDate: now,
                widgetWidth: MediaQuery.of(context).size.width,
                datePickerController: DatePickerController(),
                onValueSelected: (date) {
                  print('selected = ${date.toIso8601String()}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
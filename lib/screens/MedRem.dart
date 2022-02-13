import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pocket_doc/screens/Themes/Notif_Services.dart';
import 'package:pocket_doc/screens/add_task_bar.dart';
import 'package:pocket_doc/screens/user_homepage.dart';
import 'package:pocket_doc/widgets/button.dart';

import '../services/auth.dart';
import 'Themes/Theme.dart';
import 'Themes/Theme_Services.dart';

class MedRem extends StatefulWidget {
  const MedRem({Key? key}) : super(key: key);

  @override
  _MedRemState createState() => _MedRemState();
}

class _MedRemState extends State<MedRem> {
  DateTime _selectedDate = DateTime.now();

  var notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar(),
      body: Column(
        children: [_addTaskBar(), _addDateBar()],
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today", style: headingStyle),
              ],
            ),
          ),
          MyButton(label: "+ Add Med", onTap: () => Get.to(AddTaskPage()))
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: DatePicker(
        DateTime.now().subtract(const Duration(days: 15)),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: darkergreen,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _appbar() {
    return AppBar(
      title: const Text("Medicine Cabinet"),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserHomePage()),
            );
          },
          icon: Image.asset('assets/images/doc.png'),
          tooltip: 'Health Tracker',
        ),
        TextButton(
            onPressed: () {
              AuthService().signout();
                  },
            child: Text(
              "Log Out",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ))
      ],
      // leading: GestureDetector(
      //   onTap: () {
      //     ThemeService().switchTheme();

      //     notifyHelper.displayNotification(
      //         title: "Theme Changed",
      //         body: !Get.isDarkMode
      //             ? "Activated Dark Mode"
      //             : "Activated Light Mode");
      //     // notifyHelper.scheduledNotification();
      //     setState(() {
      //       notifyHelper.initializeNotification();
      //     });
      //   },
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Icon(
      //       Get.isDarkMode ? Icons.nightlight_round : Icons.light_mode,
      //       size: 20,
      //       color: Get.isDarkMode ? whitey : Color(0xff9c59e8),
      //     ),
      //   ),
      // ),
    );
  }
}

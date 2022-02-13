import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pocket_doc/screens/Themes/Notif_Services.dart';
import 'package:pocket_doc/screens/add_task_bar.dart';
import 'package:pocket_doc/widgets/button.dart';

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
      backgroundColor: context.theme.backgroundColor,
      appBar: _appbar(),
      body: Column(
        children:  [
          _addTaskBar(),
          _addDateBar()



        ],
      ),


    );
  }
  _addTaskBar(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),style: subHeadingStyle,),
                Text("Today", style: headingStyle),
              ],
            ),
          ),
          MyButton(label: "+ Add Med", onTap: ()=> Get.to(AddTaskPage()))

        ],
      ),
    );
  }
  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: darkergreen,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        onDateChange: (date){
          _selectedDate=date;

        },


      ),
    );

  }

  _appbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          maxRadius: 18,
          backgroundImage: NetworkImage("https://lh3.googleusercontent.com/a-/AOh14Gj5gc9rBWyq2RZoqXRO2jPdKNgrcJsmeB0Kr26Vjg=s96-c-rg-br100"),
        ),
      )],
      leading:  GestureDetector(
        onTap: () {
          ThemeService().switchTheme();

          notifyHelper.displayNotification(title:"Theme Changed",body: !Get.isDarkMode? "Activated Dark Mode": "Activated Light Mode");
          // notifyHelper.scheduledNotification();
          setState(() {
            notifyHelper.initializeNotification();

          });


        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon( Get.isDarkMode? Icons.nightlight_round: Icons.light_mode, size: 20,color: Get.isDarkMode? whitey: Color(0xff9c59e8),),
        ),

      )
      ,
    );
  }
}
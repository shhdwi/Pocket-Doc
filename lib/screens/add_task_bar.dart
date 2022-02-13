import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pocket_doc/widgets/MyInputField.dart';

import 'Themes/Theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _EndTime ="9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind =5;
  List<int> remindList =[
    5,
    10,
    15,
    20

  ];

  String _selectedRepeated ="None";
  List<String> repeatList =[
    "None",
    "Daily",
    "Weekly",
    "Monthly"



  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(),
      body: Container(
        padding: const EdgeInsets.only(left:20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Add Medicine",style: headingStyle,),
              MyInputField(title: "Name", hint: "Enter the Medicine Name"),
              MyInputField(title: "Amount", hint: "Doseage amount"),
              MyInputField(title: "Date", hint:DateFormat.yMEd().format(_selectedDate),
              widget: IconButton(
                onPressed:(){
                  _getDateFromUser();

                } , icon:Icon( Icons.calendar_today_outlined,color: Colors.grey,),
              ),),
              Row(
                children: [
                  Expanded(child: MyInputField(
                    title: "Start Time",
                    hint:_startTime ,
                    widget: IconButton(
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,


                      ), onPressed: () {
                        _getTimeFromUser(isStarTime: true);
                    },
                    ),
                  )),
                  SizedBox(width: 20,),
                  Expanded(child: MyInputField(
                    title: "End Time",
                    hint:_EndTime ,
                    widget: IconButton(
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,


                      ), onPressed: () {
                      _getTimeFromUser(isStarTime: false);
                    },
                    ),
                  )),

                ],
              ),
              MyInputField(title: "Remind", hint: "$_selectedRemind minutes early",
                widget: DropdownButton(icon:Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                  iconSize: 32,
                  elevation: 5,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  items: remindList.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),

                    );

                  }).toList(), onChanged: (String? newValue) {
                  setState(() {
                    _selectedRemind=int.parse(newValue!);
                  });
                  },

                ),
              ),
              MyInputField(title: "Repeat", hint: "$_selectedRepeated",
                widget: DropdownButton(icon:Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                  iconSize: 32,
                  elevation: 5,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  items: repeatList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: Colors.grey),),

                    );

                  }).toList(), onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeated=newValue!;
                    });
                  },

                ),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color",
                      style: titleStyle),
                      SizedBox(height: 8,),
                      Wrap(
                        children: List<Widget>.generate(3, (int index) => GestureDetector(

                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: index==0?darkpink:index==1?darkergreen:Colors.blueGrey,
                            ),
                          ),
                        )),
                      )
                    ],
                  )
                ],
              )


            ],

          ),
        )
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
          maxRadius: 20,
          backgroundImage: NetworkImage("https://lh3.googleusercontent.com/a-/AOh14Gj5gc9rBWyq2RZoqXRO2jPdKNgrcJsmeB0Kr26Vjg=s96-c-rg-br100"),
        ),
      )],
      leading:  IconButton(icon: Icon(Icons.arrow_back_ios_outlined), onPressed: () { Get.back(); },color: Get.isDarkMode?whitey:grey,)

      );
  }
  _getDateFromUser()async{
    DateTime? _pickerDate = await showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2021), lastDate: DateTime(2100));
    if (_pickerDate != null){
      setState(() {
        _selectedDate=_pickerDate;

      });


    }else{

    }
  }
  _getTimeFromUser( {required bool isStarTime}) async {
    var pickedTime= await _showTimePicker();
    String _formattedTime=pickedTime.format(context);
    if (pickedTime==null){
      print("Time Cancelled");

    }else if(isStarTime==true){
      setState(() {
        _startTime=_formattedTime;

      });

    }else if (isStarTime==false){
      setState(() {
        _EndTime =_formattedTime;

      });

    }

  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context, initialTime: TimeOfDay(hour: int.parse(_startTime.split(":")[0]), minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pocket_doc/controller/medicine_controller.dart';
import 'package:pocket_doc/widgets/MyInputField.dart';
import 'package:pocket_doc/widgets/button.dart';

import '../models/medicine.dart';
import 'Themes/Theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final MedicineController _medicineController =Get.put(MedicineController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amtController = TextEditingController();
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
  int _selectedColor =0;
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
              MyInputField(title: "Name", hint: "Enter the Medicine Name",controller: _titleController,),
              MyInputField(title: "Amount", hint: "Doseage amount",controller: _amtController,),

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color",
                      style: titleStyle),
                      SizedBox(height: 8,),
                      Wrap(
                        children: List<Widget>.generate(3, (int index) => GestureDetector(
                          onTap: (){
                            setState(() {
                              _selectedColor=index;
                            });


                          },

                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: index==0?darkpink:index==1?darkergreen:Colors.blueGrey,
                              child: _selectedColor==index?Icon(Icons.done,
                              color: Colors.white,
                              size: 16,):Container(),

                            ),
                          ),
                        )),
                      )
                    ],
                  ),
                  MyButton(label: "Add Medicine", onTap:()=>_validatedata())

                ],
              )


            ],

          ),
        )
      ),

    );
  }
  _validatedata(){
    if(_titleController.text.isNotEmpty&&_amtController.text.isNotEmpty){
      _addMedtoDB();
      Get.back();

    }else if(_titleController.text.isEmpty || _amtController.text.isEmpty){
      Get.snackbar("Required", "All fields are Required",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
        icon: Icon(Icons.warning_amber_rounded)
      )
      ;

    }

  }
  _addMedtoDB()async{

    int _value = await _medicineController.addMedicine(
      medicine:


    Medicine(
      note: _amtController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime:_EndTime,
      remind: _selectedRemind,
      repeat: _selectedRepeated,
      color: _selectedColor,
      isCompleted: 0
    ));
    print(_value);
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


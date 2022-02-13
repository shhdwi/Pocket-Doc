import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:velocity_x/velocity_x.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    DateTime startDate = now.subtract(const Duration(days: 14));
    DateTime dateSelected = now;

    CollectionReference health_status =
        FirebaseFirestore.instance.collection('health_status');

    Future<void> addStatus(String status) {
      // Call the user's CollectionReference to add a new user
      return health_status
          .add({'user': userId, 'date': dateSelected, 'status': status})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Future<void> updateStatus(String status) {
      // Call the user's CollectionReference to add a new user
      return health_status
          .where('date', isEqualTo: dateSelected)
          .where('user', isEqualTo: userId)
          .set({'user': userId, 'date': dateSelected, 'status': status})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Tracker"),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            VxArc(
              height: 20,
              child: Container(
                decoration: const BoxDecoration(
                  color: const Color(0xff221f2c),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                  child: Text(
                    "Hi, how is your health today ?",
                    textScaleFactor: 4,
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: myController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      labelText: 'Your health status',
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                  ).px16().py32(),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff2921cb),
                onPrimary: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('health_status')
                    .where('date', isEqualTo: dateSelected)
                    .where('user', isEqualTo: userId)
                    .get()
                    .then((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                    updateStatus(myController.text);
                  } else {
                    addStatus(myController.text);
                  }
                });
              },
              child: const Text('SUBMIT').px32().py8(),
            ).py16(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: DatePicker(
                    startDate,
                    initialSelectedDate: now,
                    selectionColor: Color(0xffa7beb7),
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        dateSelected = date;
                        FirebaseFirestore.instance
                            .collection('health_status')
                            .where('date', isEqualTo: dateSelected)
                            .where('user', isEqualTo: userId)
                            .get()
                            .then((DocumentSnapshot documentSnapshot) {
                          if (documentSnapshot.exists) {
                            myController.text =
                                documentSnapshot.data()['status'];
                          }
                        });
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

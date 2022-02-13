import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:pocket_doc/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../services/UserModel.dart';
import 'MedRem.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final myController = TextEditingController();
  DateTime dateSelected = DateTime.now();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    final userId = user?.uid;

    var now = DateTime.now();
    DateTime startDate = now.subtract(const Duration(days: 14));

    CollectionReference health_status =
        FirebaseFirestore.instance.collection('health_status');

    Future<void> addStatus(String status) {
      final snackBarSuccess = SnackBar(
        content: const Text('Pocket Doc has read your status !'),
      );
      final snackBarError = SnackBar(
        content: const Text('Sorry! Pocket Doc could not read your status.'),
      );
      return health_status
          .add({'user': userId, 'date': dateSelected, 'status': status})
          .then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess))
          .catchError((error) =>
              ScaffoldMessenger.of(context).showSnackBar(snackBarError));
    }

    Future<void> updateStatus(String id, String status) {
      final snackBarSuccess = SnackBar(
        content: const Text('Pocket Doc has read your status !'),
      );
      final snackBarError = SnackBar(
        content: const Text('Sorry! Pocket Doc could not read your status.'),
      );
      return health_status
          .doc(id)
          .set({'user': userId, 'date': dateSelected, 'status': status})
          .then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess))
          .catchError((error) =>
              ScaffoldMessenger.of(context).showSnackBar(snackBarError));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Tracker"),
        actions: <Widget>[
          IconButton(
            onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MedRem()),
            );}, 
            icon: Image.asset('assets/images/medrem.png'), 
            tooltip: 'Medicine Cabinet',
            ),
            TextButton(
              onPressed: () {
            AuthService().signout();
            },
              child: Text("Log Out", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
            )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
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
                      .then((QuerySnapshot querySnapshot) {
                    if (querySnapshot.docs.isEmpty) {
                      addStatus(myController.text);
                    } else {
                      querySnapshot.docs.forEach((doc) {
                        updateStatus(doc.id, myController.text);
                      });
                    }
                  });
                },
                child: const Text('SUBMIT').px32().py8(),
              ).py16(),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: DatePicker(
                    startDate,
                    initialSelectedDate: null,
                    selectionColor: Color(0xffa7beb7),
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      //New date selected
                      setState(() {
                        dateSelected = date;
                        FirebaseFirestore.instance
                            .collection('health_status')
                            .where('date', isEqualTo: dateSelected)
                            .where('user', isEqualTo: userId)
                            .get()
                            .then((QuerySnapshot querySnapshot) {
                          if (querySnapshot.docs.isNotEmpty) {
                            querySnapshot.docs.forEach((doc) {
                              myController.text = doc.get('status');
                            });
                          } else {
                            myController.text = "";
                          }
                        });
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

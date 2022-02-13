import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pocket_doc/controller/db/db_helper.dart';
import 'package:pocket_doc/screens/MedRem.dart';
import 'package:pocket_doc/screens/Signin.dart';
import 'package:pocket_doc/screens/Themes/Theme.dart';
import 'package:pocket_doc/screens/Themes/Theme_Services.dart';
import 'package:pocket_doc/screens/user_homepage.dart';
import 'package:pocket_doc/services/UserModel.dart';
import 'package:pocket_doc/services/auth.dart';
import 'package:pocket_doc/themes/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pocket Doc',
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme,
        home: MedRem(),

      ),
    );
  }
}



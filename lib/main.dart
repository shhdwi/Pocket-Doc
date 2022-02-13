import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pocket_doc/screens/MedRem.dart';
import 'package:pocket_doc/screens/Themes/Theme.dart';
import 'package:pocket_doc/screens/Themes/Theme_Services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(


      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home:MedRem(),
      debugShowCheckedModeBanner: false,
    );
  }
}

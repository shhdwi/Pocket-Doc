import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color lightpink = Color(0xffc8a5ee);
const Color whitey = Color(0xfff0f1f9);
const Color darkpink = Color(0xff9c59e8);
const Color blu = Color(0xff2921cb);
const Color grey = Color(0xff221f2c);
const Color lightgreen = Color(0xffa7beb7);
const Color darkergreen = Color(0xff6e8e86);

class Themes{

  static final light = ThemeData(
    backgroundColor: whitey,
    primaryColor:lightpink,
    brightness: Brightness.light,

  );
  static final dark = ThemeData(
    backgroundColor: grey,
    primaryColor: darkpink,
    brightness: Brightness.dark,

  );

}
TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
        color: Get.isDarkMode?Colors.grey[400]:Colors.grey
    )

  );
}
TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode?Colors.white:Colors.black
      )

  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode?Colors.white:Colors.black
      )

  );
}
TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode?Colors.grey[100]:Colors.grey[400]
      )

  );
}


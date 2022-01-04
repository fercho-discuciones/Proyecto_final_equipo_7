// ignore_for_file: file_names

import 'package:flutter/material.dart';

const Color primary = Color(0xffD0CCD0);
const Color whitee = Color(0xffFBFCFF);
const Color brown = Color(0xff605856);
const Color blueSaphire = Color(0xff1C6E8C);
const Color blueCharcoal= Color(0xff274156);

ThemeData myTheme(BuildContext con){
  return ThemeData(
    primaryColor: primary,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey
    ).copyWith(
      secondary: Colors.blueGrey[700]
    )
  );
}
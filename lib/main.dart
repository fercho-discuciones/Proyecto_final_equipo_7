// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:proyectofinal001/FirstScreen.dart';
import 'package:proyectofinal001/Theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme(context),
      routes: {
        '/': (context)=>FirstScreen(),
      },
      initialRoute: '/',
    );
  }
}
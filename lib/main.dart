import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home_ui/class_builder.dart';
import 'package:flutter_smart_home_ui/themes/app_theme.dart';

import 'Login.dart';
import 'MainWidget.dart';
import 'SignUp.dart';
import 'Start.dart';

void main() async {
  ClassBuilder.registerClasses();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,



      home: MainWidget(),

      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>Login(),
        "SignUp":(BuildContext context)=>SignUp(),
        "start":(BuildContext context)=>Start(),
      },
    );
  }
}







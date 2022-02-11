// ignore_for_file: prefer_const_constructors, camel_case_types

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendify/screen/maiPageScreen/showConversation.dart';

import 'screen/loading.dart';
import 'screen/log_in.dart';
import 'screen/maiPageScreen/PeopleTab.dart';
import 'screen/mainPage.dart';
import 'screen/registred.dart';

void main(List<String> args) {
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        
       "/": (_) => Loading(),
        "/log_in": (_) => log_in(),
        "/sing_up": (_) => Registred(),
        "/main": (_) => MainPage(),
        "/showConversation": (_) => conversation()
      },
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
    );
  }
}

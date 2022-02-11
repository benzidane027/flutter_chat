// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_this

import 'dart:async';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isload = false;
  String defualt = "";
  @override
  void initState() {
    super.initState();
    this.time();
  }
  void time() {
    Timer(Duration(seconds: 5), (){
      Navigator.pushNamedAndRemoveUntil(context, "/log_in", (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SizedBox(
            child: CircularProgressIndicator(),
            width: 52,
            height: 52,
          ),
        ),
      ),
    );
  }
}
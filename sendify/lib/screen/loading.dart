// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_this

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sendify/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isload = false;
  String defualt = "";
  User user = User();
  @override
  void initState() {
    super.initState();
    this.redirect();
  }

  void redirect() async {
    String? token = (await SharedPreferences.getInstance()).getString("token");
    if (token == null)
      Navigator.pushNamedAndRemoveUntil(context, "/log_in", (route) => false);
    else {
      bool resualt = await user.log_in_fromToken(token);
      if (resualt)
        Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false,
            arguments: user.token);
      else
        Navigator.pushNamedAndRemoveUntil(context, "/log_in", (route) => false);
    }
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

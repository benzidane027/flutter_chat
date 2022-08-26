// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sendify/models/model.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:sendify/screen/maiPageScreen/PeopleTab.dart';
import 'package:sendify/screen/maiPageScreen/messagesTab.dart';
import 'package:sendify/screen/maiPageScreen/homeTab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  @override
  int myIndex = 0;
  Timer? handeler;
  var user = User();
  String fname = "";
  String? lname;
  String? username;
  String token = "";
  late TabController mycontroller;
  List screen = [
    MessageViewer(),
    Icon(Icons.person),
    Icon(Icons.home),
  ];
  @override
  void initState() {
    super.initState();
    mycontroller = TabController(length: 3, vsync: this);
    this.change();
  }

  void change() {
    mycontroller.addListener(() {
      //print(myIndex);
      this.myIndex = mycontroller.index;
      setState(() {});
    });
  }

  @override
  void dispose() {
    mycontroller.dispose();
    super.dispose();
  }

  connect() async {
    await user.log_in_fromToken(this.token);
    handeler = Timer.periodic(Duration(seconds: 30), (timer) {
      user.i_am_here();
      print("here");
    });

    username = user.username;
    fname = user.fname.toString();
    lname = user.lname;

    setState(() {});
  }

  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)?.settings.arguments;
    token = res.toString();
    if (fname == "") connect();
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(fname.toString() + " " + lname.toString(),
                style: TextStyle(fontFamily: "Ubuntu", fontSize: 25))),
        actions: [
          PopupMenuButton(
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Center(
                        child: Text("conatct us"),
                      ),
                    ),
                    PopupMenuItem(child: Center(child: Text("about"))),
                    PopupMenuItem(
                        child: GestureDetector(
                            onTap: () async {
                              var prefs = await SharedPreferences.getInstance();
                              await prefs.clear();
                              await user.deconnect();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/log_in", (route) => false);
                            },
                            child: Center(child: Text("deconnect"))))
                  ])
        ],
      ),
      body: Scaffold(
        bottomNavigationBar: ConvexAppBar.badge(<int, dynamic>{0: ""},
            controller: mycontroller,
            style: TabStyle.reactCircle,
            items: <TabItem>[
              TabItem(title: "message", icon: Icons.message),
              TabItem(title: "people", icon: Icons.people),
              TabItem(title: "home", icon: Icons.home),
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: IndexedStack(
              index: mycontroller.index,
              children: [
                MessageViewer(),
                people(),
                Home(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_print, curly_braces_in_flow_control_structures

import 'dart:async';

import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sendify/models/model.dart';

class people extends StatefulWidget {
  const people({Key? key}) : super(key: key);

  @override
  _peopleState createState() => _peopleState();
}

class _peopleState extends State<people> {
  List users_active = [];
  List all_users = [];
  bool is_all_use_load = false, is_all_use_active_load = false;

  Timer? handler;
  @override
  void initState() {
    super.initState();
    connect01();
    connect02();
    handler = Timer.periodic(Duration(seconds: 30), (_) {
      if (!mounted)
        handler?.cancel();
      else
        connect02();
    });
  }

  Future<void> connect01() async {
    print("get all users");
    Map resualt = await User.get_all_user();
    all_users = resualt["msg"];
    setState(() {
      is_all_use_load = true;
    });
  
  }

  Future<void> connect02() async {
    print("get users active");

    Map resualt = await User.get_users_active();
    users_active = resualt["msg"];
    setState(() {
      is_all_use_active_load = true;
    });
   // print(users_active);
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                Tab(
                  child: Text("user active"),
                ),
                Tab(
                  child: Text("all users"),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              LimitedBox(
                child: !is_all_use_active_load
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        itemCount: users_active.length,
                        itemBuilder: (_, __) {
                          return InkWell(
                            onTap: () {
                              print(users_active[__]["id"]);
                              Navigator.pushNamed(context, "/showConversation",
                                  arguments: users_active[__]["id"]);
                            },
                            child: Container(
                              color: Colors.white10,
                              margin: EdgeInsets.all(4),
                              height: 55,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.green, width: 1),
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.user,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "  " +
                                            users_active[__]["fname"]
                                                .toString() +
                                            " " +
                                            users_active[__]["lname"]
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 19, fontFamily: "Ubuntu"),
                                      ),
                                      Text("   " +
                                          users_active[__]["username"]
                                              .toString())
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
              ),
              LimitedBox(
                child: !is_all_use_load
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        itemCount: all_users.length,
                        itemBuilder: (_, __) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/showConversation",
                                  arguments: all_users[__]["id"]);
                            },
                            child: Container(
                              color: Colors.white10,
                              margin: EdgeInsets.all(4),
                              height: 55,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue, width: 1),
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.user,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "  " +
                                            all_users[__]["fname"].toString() +
                                            " " +
                                            all_users[__]["lname"].toString(),
                                        style: TextStyle(
                                            fontSize: 19, fontFamily: "Ubuntu"),
                                      ),
                                      Text("   " +
                                          all_users[__]["username"].toString())
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
              ),
            ],
          ),
        ));
  }
}

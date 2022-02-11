// ignore_for_file: file_names, prefer_const_constructors, annotate_overrides, avoid_unnecessary_containers, non_constant_identifier_names, prefer_const_literals_to_create_immutables, override_on_non_overriding_member, unnecessary_this, avoid_print, curly_braces_in_flow_control_structures
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sendify/models/model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageViewer extends StatefulWidget {
  MessageViewer({Key? key});
  @override
  _MessageViewerState createState() => _MessageViewerState();
}

class _MessageViewerState extends State<MessageViewer> {
  @override
  bool first = true;
  var mymessage = Messages();
  List<Map> msg_view = [];
  bool isload = false;
  Timer? handeler;

  @override
  void initState() {
    super.initState();
    if (first) {
      first = false;
    }
    this.get_message();
    handeler = Timer.periodic(Duration(seconds: 10), (timer) {
      this.get_message();
    });
  }

  void get_message() async {
    print("get messages");
    msg_view.clear();
    Map resualt = await mymessage.get_messages_list();
    resualt.forEach((key, value) {
      msg_view.add(value);
    });
    //print(msg_view);
    if (mounted)
      setState(() {
        isload = true;
      });
  }

  Widget build(BuildContext context) {
    return Container(
      child: !isload
          ? Center(
              child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: LinearProgressIndicator(),
            ))
          : ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemCount: msg_view.length,
              itemBuilder: (_, __) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/showConversation",
                        arguments: msg_view[__]["id"]);
                  },
                  onLongPress: () {
                    showBottomSheet(
                        context: context,
                        builder: (_) {
                          return Container(
                            margin: EdgeInsets.only(left: 1, right: 1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Text("good"),
                          );
                        });
                  },
                  child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ],
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      margin: EdgeInsets.fromLTRB(3, 5, 4, 5),
                      child: Row(
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.user,
                                size: 30,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  msg_view[__]["fname"] +
                                      " " +
                                      msg_view[__]["lname"],
                                  style: TextStyle(
                                      fontFamily: "Ubuntu",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  child: Text(msg_view[__]["content"]
                                              .toString()
                                              .length >
                                          15
                                      ? msg_view[__]["content"]
                                              .toString()
                                              .substring(0, 25) +
                                          "..."
                                      : msg_view[__]["content"]),
                                )
                              ],
                            ),
                          )),
                          Container(
                              width: 65,
                              height: 54,
                              margin: EdgeInsets.only(right: 3),
                              padding: EdgeInsets.all(1),
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                msg_view[__]["status"] == 0
                                    ? "not seen"
                                    : "seen",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              ))
                        ],
                      )),
                );
              }),
    );
  }
}

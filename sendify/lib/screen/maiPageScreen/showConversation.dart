// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, prefer_is_empty, curly_braces_in_flow_control_structures, avoid_print

import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sendify/models/model.dart';

class conversation extends StatefulWidget {
  const conversation({Key? key}) : super(key: key);

  @override
  _conversationState createState() => _conversationState();
}

class _conversationState extends State<conversation> {
  @override
  var user = User();
  var message = Messages();
  List<dynamic> msg_viewer = [];
  bool isload_message = false,
      isLoad_info = false,
      status = false,
      first = true;
  var message_controller = TextEditingController();
  String? fname, lname, username;
  Timer? handlert;

  Future<void> get_data(id) async {
    Map temp = await message.get_conversation(reciver_id: id);
    msg_viewer = temp["msg"];
    if (mounted) setState(() {});
  }

  Future<void> send_messages(id) async {
    print(message_controller.text);
    if (message_controller.text.toString().trim().length > 0) {
      var resualt = await message.send_message(
          reciver_id: id, content: message_controller.text.toString().trim());
      message_controller.text = "";
      print(resualt);
      get_data(id);
    }
  }

  Future<void> reciver_status(id) async {
    //await user.i_am_here();
    bool status_;
    Map resualt = await user.get_isUser_active(id);
    List temp = resualt["msg"];
    if (temp.length > 0)
      status_ = true;
    else
      status_ = false;
    if (status_ != status) if (mounted)
      setState(() {
        status = status_;
      });
  }

  Future<void> reciver_info(id) async {
    Map resualt = await user.get_user_info(id: id);
    Map temp = resualt["msg"][0];
    fname = temp["fname"];
    lname = temp["lname"];
    username = temp["username"];
    print("reciver info");
    setState(() {
      isLoad_info = true;
    });
  }

  connect(id) {
    reciver_info(id);
    get_data(id);
    reciver_status(id);

    handlert = Timer.periodic(Duration(seconds: 8), (_) {
      get_data(id);
      reciver_status(id);
      print("connect");
      if (!mounted) {
        handlert?.cancel();
      }
    });
  }

  Widget build(BuildContext context) {
    var res = ModalRoute.of(context)?.settings.arguments;
    //var res = "8";
    if (first) {
      connect(res.toString());
      first = false;
    }
    var sizeY = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(itemBuilder: (_) {
            return [
              PopupMenuItem(child: Text("test 01")),
              PopupMenuItem(child: Text("test 02"))
            ];
          })
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            status
                ? FaIcon(
                    FontAwesomeIcons.dotCircle,
                    color: Colors.green[700],
                    size: 15,
                  )
                : FaIcon(
                    FontAwesomeIcons.dotCircle,
                    color: Colors.red[500],
                    size: 15,
                  ),
            SizedBox(width: 10),
            isLoad_info
                ? Text(fname.toString() + " " + lname.toString())
                : Text("conecting..")
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  itemCount: msg_viewer.length,
                  itemBuilder: (_, __) {
                    //message i send
                    double pading_right;
                    double padind_left;
                    var alignment;
                    double border_right;
                    double border_left;

                    if (msg_viewer[__]["sender_id"].toString() ==
                        res.toString()) {
                      pading_right = sizeY * 0.25;
                      padind_left = 10;
                      alignment = AlignmentDirectional.centerStart;
                      border_right = 7;
                      border_left = 1;
                    } else {
                      pading_right = 10;
                      padind_left = sizeY * 0.25;
                      alignment = AlignmentDirectional.centerEnd;
                      border_right = 1;
                      border_left = 7;
                    }
                    return Container(
                        margin: EdgeInsets.only(top: 4),
                        //   color: Colors.green,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: alignment,
                          children: [
                            Container(
                              //   color: Colors.red,
                              //more edit needed here
                              margin: EdgeInsets.only(right: pading_right),
                              padding: EdgeInsets.only(left: padind_left),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(7),
                                          topRight: Radius.circular(7),
                                          bottomLeft:
                                              Radius.circular(border_left),
                                          bottomRight:
                                              Radius.circular(border_right))),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    msg_viewer[__]["content"].toString(),
                                    style: TextStyle(fontSize: 15.5),
                                  )),
                              //color: Colors.red,
                            )
                          ],
                        ));
                  })),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 2),
              child: TextField(
                maxLength: 100,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  contentPadding:EdgeInsets.only(left: 10,top: 5),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        //temp
                        send_messages(res.toString());
                      },
                    ),
                    counter: Text(""),
                    label: Text("message"),
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
                controller: message_controller,
              )),
        ],
      ),
    );
  }
}

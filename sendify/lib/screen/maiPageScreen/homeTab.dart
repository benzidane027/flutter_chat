// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sendify/models/model.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> data = [];

  Future<void> get_info() async {
    Map resualt = await User.get_curr_user_info();
    print(resualt["msg"][0]["fname"]);

    data.add(resualt["msg"][0]["fname"]);
    data.add(resualt["msg"][0]["lname"]);
    data.add(resualt["msg"][0]["username"]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (data.length == 0) get_info();
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          height: 200,
          // color: Colors.blue,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ]),
                margin: EdgeInsets.all(12),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    size: 80,
                  ),
                ),
              )),
              Expanded(
                  child: ListView.builder(
                padding: EdgeInsets.only(top: 15, right: 5),
                itemCount: data.length,
                itemBuilder: (_, __) => Container(
                  child: Center(
                      child: Text(
                    data[__],
                    style: TextStyle(fontFamily: "Ubuntu", fontSize: 20),
                  )),
                  height: 50,
                  margin: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1, color: Colors.blue.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 20,
                          offset: Offset(0, 5),
                        )
                      ]),
                ),
              ))
            ],
          ),
        ),
        InkWell(
          onTap: () {
            print("hh");
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: EdgeInsets.only(left: 10, right: 10, top: 100),
            child: Center(child: Text("privacy policy")),
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  )
                ]),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Center(child: Text("edit account")),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: Offset(0, 5),
                )
              ]),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Center(child: Text("app setting")),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: Offset(0, 5),
                )
              ]),
        )
      ],
    ));
  }
}

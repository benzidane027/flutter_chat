// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:sendify/models/model.dart';

class log_in extends StatefulWidget {
  const log_in({Key? key}) : super(key: key);

  @override
  _log_inState createState() => _log_inState();
}

class _log_inState extends State<log_in> {
  @override
  var username_controller = TextEditingController();
  var password_controller = TextEditingController();

  static String msg = "";
  Widget msg_field = Text(
    msg,
    style: TextStyle(color: Colors.red),
  );

  var user = User();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Log In",
              style: TextStyle(fontFamily: "Ubuntu", fontSize: 25)),
        ),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: username_controller,
                    decoration: InputDecoration(
                        label: Text("username"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: password_controller,
                    decoration: InputDecoration(
                        label: Text("password"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                child: Divider(
                  height: 10,
                  endIndent: 20,
                  indent: 20,
                )),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: msg_field,
            ),
            SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        msg_field = LinearProgressIndicator();
                      });
                      bool resualt = await user.log_in(
                          username: username_controller.text,
                          password: password_controller.text);
                      // print(resualt);
                      if (resualt)
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/main", (route) => false,
                            arguments: user.token);
                      else
                        msg = "user not found";
                      setState(() {
                        msg_field = Text(
                          msg,
                          style: TextStyle(color: Colors.red),
                        );
                      });
                    },
                    child: Text("log In",
                        style: TextStyle(fontFamily: "Ubuntu", fontSize: 18)),
                    style: ButtonStyle(),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 100,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamedAndRemoveUntil(context, "/sing_up", (route) => false);
                      Navigator.pushNamed(context, "/sing_up");
                    },
                    child: Text("sing Up",
                        style: TextStyle(fontFamily: "Ubuntu", fontSize: 18)),
                    style: ButtonStyle(),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

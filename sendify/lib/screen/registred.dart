// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sendify/models/model.dart';

class Registred extends StatefulWidget {
  @override
  _RegistredState createState() => _RegistredState();
}

class _RegistredState extends State<Registred> {
  @override
  var user = User();
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  static String msg = "";
  Widget msg_field = Text(
    msg,
    style: TextStyle(color: Colors.red),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Sing Up",
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          controller: controllers[0],
                          decoration: InputDecoration(
                              label: Text("first name"),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          controller: controllers[1],
                          decoration: InputDecoration(
                              label: Text("last name"),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: controllers[2],
                    decoration: InputDecoration(
                        label: Text("username"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: controllers[3],
                    decoration: InputDecoration(
                        label: Text("password"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: controllers[4],
                    decoration: InputDecoration(
                        label: Text("re-password"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                )
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
                  width: 100,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      /* Navigator.pushNamedAndRemoveUntil(
                          context, "/log_in", (route) => false);*/
                      Navigator.of(context).pop();
                    },
                    child: Text("log In", style: TextStyle(fontFamily: "Ubuntu", fontSize: 18)),
                    style: ButtonStyle(),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 200,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        msg_field = LinearProgressIndicator();
                      });
                      List<String> errors = [];

                      controllers.forEach((element) {
                        if (element.text.isEmpty) {
                          errors.add("error: empty field");
                        }
                      });

                      if (controllers[3].text != controllers[4].text) {
                        errors.add("error: password not in same field");
                      }
                      if (controllers[3].text.length < 6) {
                        errors.add("error: password should be than 6");
                      }

                      if (errors.length == 0) {
                        Map resualt = await User.sing_up(
                            fname: controllers[0].text,
                            lname: controllers[1].text,
                            username: controllers[2].text,
                            password: controllers[3].text);

                        print(resualt);
                        if (resualt["msg_type"] == "succ") {
                          msg = "Successfuly regristres";
                          msg_field = Text(msg,
                              style: TextStyle(
                                color: Colors.green,
                              ));
                          controllers.forEach((e) => e.text = "");
                          setState(() {});
                        } else {
                          msg = "error: " + resualt["msg"][0]["msg"];
                          msg_field = Text(msg,
                              style: TextStyle(
                                color: Colors.red,
                              ));
                        }
                        setState(() {});
                      } else {
                        msg = errors[0];
                        msg_field = Text(msg,
                            style: TextStyle(
                              color: Colors.red,
                            ));
                        setState(() {});
                      }
                    },
                    child: Text("registred",
                        style: TextStyle(fontFamily: "Ubuntu", fontSize: 18)),
                   
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

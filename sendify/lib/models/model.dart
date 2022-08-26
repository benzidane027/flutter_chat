import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String host = "http://10.0.0.5";
String port = "3000";
Map<String, String> headers_ = {};
void updateCookie(http.Response response) {
  String? rawCookie = response.headers['set-cookie'];
  if (rawCookie != null) {
    int index = rawCookie.indexOf(';');
    headers_['cookie'] =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
  }
}

class User {
  String? fname;
  String? lname;
  String? username;
  String? token = "";
  static var client = http.Client();

  User();

  Future<bool> log_in_fromToken(String token) async {
    var req = await http.post(Uri.parse("$host:$port/users/user_from_tokken"),
        body: <String, String>{"token": token}, headers: headers_);
    Map resualt = jsonDecode(req.body);
    updateCookie(req);

    if (resualt["msg_type"] == "succ") {
      this.username = resualt["username"];
      this.fname = resualt["fname"];
      this.lname = resualt["lname"];
      this.token = resualt["token"];

      return true;
    }
    return false;
  }

  Future<bool> log_in({username = "", password = ""}) async {
    var req = await client.post(Uri.parse("$host:$port/users/login"),
        body: <String, String>{"username": username, "password": password},
        headers: headers_);
    var prefs = await SharedPreferences.getInstance();
    Map resualt = jsonDecode(req.body);

    updateCookie(req);
    if (resualt["msg_type"] == "succ") {
      this.fname = resualt["fname"];
      this.lname = resualt["lname"];
      this.token = resualt["token"];
      prefs.setString("token", resualt["token"]);
      return true;
    }
    return false;
  }

  static Future<Map> sing_up(
      {required fname,
      required lname,
      required username,
      required password}) async {
    var req = await http.post(Uri.parse("$host:$port/users/singup"),
        body: <String, String>{
          "username": username,
          "password": password,
          "fname": fname,
          "lname": lname
        });
    Map resualt = jsonDecode(req.body);
    return resualt;
  }

  static Future<Map> get_all_user() async {
    var req = await client.get(Uri.parse("$host:$port/users/all_user"),
        headers: headers_);
    updateCookie(req);
    Map resualt = jsonDecode(req.body);
    return resualt;
  }

  Future<Map> get_isUser_active(reciver_id) async {
    var req = await http.get(
        Uri.parse("$host:$port/status/user_active/$reciver_id"),
        headers: headers_);
    updateCookie(req);
    Map resualt = jsonDecode(req.body);
    return resualt;
  }

  static Future<Map> get_users_active() async {
    var req = await client.get(Uri.parse("$host:$port/status/users_active"),
        headers: headers_);
    updateCookie(req);

    Map resualt = jsonDecode(req.body);
    return resualt;
  }

  Future<Map> get_user_info({id = ""}) async {
    var req = await client.get(Uri.parse("$host:$port/users/user_from_id/$id"),
        headers: headers_);
    updateCookie(req);
    Map resualt = jsonDecode(req.body);
    return resualt;
  }

  static Future<Map> get_curr_user_info() async {
    var req = await client.get(Uri.parse("$host:$port/users/curr_user_info"),
        headers: headers_);
    updateCookie(req);
    Map resualt = jsonDecode(req.body);
    return resualt;
  }

  Future<void> i_am_here() async {
    var req = await client.post(Uri.parse("$host:$port/status/i_am_here"),
        headers: headers_);
    updateCookie(req);
  }

  Future deconnect() async {
    var req = await client.post(Uri.parse("$host:$port/users/disconnect"),
        headers: headers_);
    updateCookie(req);
  }

// for later
  void edit_info(String fname, String lname, String username) async {}
  void update_password(String newPassword) {}
  void removeToken_from_database() {}
  void insert_token(String token) {}
  bool check() {
    return false;
  }
}

class Messages {
  String? content;
  int? reciver_id;
  int? sender_id;

  Future<bool> send_message({reciver_id: "", content: ""}) async {
    var req = await http.post(Uri.parse("$host:$port/messages/send_message"),
        body: <String, String>{"reciver_id": reciver_id, "content": content},
        headers: headers_);
    updateCookie(req);
    Map resualt = jsonDecode(req.body);
    if (resualt["msg_type"] == "succ") {
      return true;
    }
    return false;
  }

  Future<Map> get_conversation({reciver_id: ""}) async {
    var req = await http.get(
        Uri.parse("$host:$port/messages/get_convrersation/$reciver_id"),
        headers: headers_);
    updateCookie(req);

    Map resualt = jsonDecode(req.body);
    return resualt;
  }

  Future<Map> get_messages_list() async {
    var req = await http.get(
        Uri.parse("$host:$port/messages/get_messages_list"),
        headers: headers_);
    updateCookie(req);

    Map<String, dynamic> temp_resualt = jsonDecode(req.body);
    Map<int, dynamic> resualt = {};
    List<dynamic> temp_list = temp_resualt["msg"];
    temp_list.forEach((element) {
      resualt.addAll({element["id"]: element});
    });
    return resualt;
  }
}

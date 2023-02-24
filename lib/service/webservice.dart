import 'dart:convert';

import 'package:chat_box/constants/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Webservice{
  static Future<Map<String,dynamic>> fetchChats()
  async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  var req={
    "userID":sharedPreferences.getInt("userId")
  };

    var response=await http.post(Uri.parse(Endpoints.getChatUrl),body: jsonEncode(req),headers: {'Content-Type':'application/json'});
    return jsonDecode(response.body);
  }
  static Future<Map<String,dynamic>> fetchUsers(String searchText)
  async{
    var req={
     "search":searchText
    };
    var response=await http.post(Uri.parse(Endpoints.getUserUrl),body: jsonEncode(req),headers: {'Content-Type':'application/json'});
    return jsonDecode(response.body);
  }
}
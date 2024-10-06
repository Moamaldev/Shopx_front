import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserState with ChangeNotifier {
  Future<bool> loginNow(String uName, String pass) async {
    String url = 'http://10.0.2.2:8000/api/login/';
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({'username': uName, 'password': pass}));
      var data = json.decode(response.body) as Map;

      if (data.containsKey("token")) {
        print(data['token']); // login done
        return true;
      }
      print(false); // login filed
      return false;
      // print(response.body);
      // return true;
    } catch (e) {
      print('e in loginNow : $e');
      return false;
    }
  }
}

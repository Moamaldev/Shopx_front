import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopx/state/dataStore/local_Storge.dart';
// import 'package:localstorage/localstorage.dart';

class UserState with ChangeNotifier {
  // LocalStorage storage = LocalStorage('usertoken');

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
        await CacheNetwork.insertToCache(key: 'token', val: data['token']);

        // print(CacheNetwork.getFromCache(key: 'token')); // login done
        return true;
      }
      // print(false); // login filed
      return false;
    } catch (e) {
      print('e in loginNow : $e');
      return false;
    }
  }

  Future<bool> registerNew(String fname, String lname, String email,
      String uname, String pass) async {
    String url = 'http://10.0.2.2:8000/api/register/';
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            'username': uname,
            'password': pass,
            'first_name': fname,
            'last_name': lname,
            'email': email
          }));
      var data = json.decode(response.body) as Map;
      print(data);

      if (data['error'] == false) {
        //whene false in server it mean true ohne error

        return true;
      }
      print('mit error');
      return false; //mit error
    } catch (e) {
      print('e in registerNew : $e');
      return false;
    }
  }
}

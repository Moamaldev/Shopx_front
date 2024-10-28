import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopx/models/user.dart';
import 'package:shopx/state/dataStore/local_Storge.dart';

class FetchSingelUser with ChangeNotifier {
  User? _user;
  User? get user => _user;

  Future<void> fetchUserData() async {
    var userToken = CacheNetwork.getFromCache(key: 'token');

    final url = Uri.parse('http://10.0.2.2:8000/api/user-profile/');
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Token $userToken', // إرسال التوكن في الترويسة
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _user = User.fromJson(data);
        notifyListeners(); // تحديث الواجهة
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchUserById(String id) async {
    if (_Usersbyid.containsKey(id)) {
      return; // إذا كان المستخدم موجودًا بالفعل، لا تقم بإعادة تحميله
    }

    var userToken = CacheNetwork.getFromCache(key: 'token');

    final url = Uri.parse('http://10.0.2.2:8000/api/users/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Token $userToken', // إرسال التوكن في الترويسة
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _Usersbyid[id] = User.fromJson(data); // تخزين المستخدم في الخريطة
        notifyListeners();
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw error;
    }
  }

  Map<String, User> _Usersbyid = {}; // تخزين المستخدمين حسب الـ id

  User? getUserById(String id) {
    return _Usersbyid[id]; // إرجاع المستخدم المخزن حسب الـ id
  }
}

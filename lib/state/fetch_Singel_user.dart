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
}

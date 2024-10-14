import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopx/state/dataStore/local_Storge.dart';

class OrderState with ChangeNotifier {
  Future<bool> newOrder(
      String total,
      String email,
      String phone,
      String address,
      String paymentMethod,
      int uid,
      List<Map<String, dynamic>> products) async {
    String url = 'http://10.0.2.2:8000/api/ordercreate/';
    var userToken = CacheNetwork.getFromCache(key: 'token');

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Token $userToken',
          },
          body: json.encode({
            'products_list': products,
            'total': total,
            'email': email,
            'phone': phone,
            'address': address,
            'payment_method': paymentMethod,
            'user': uid,
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
      print('e in newOrder : $e');

      return false;
    }
  }
}

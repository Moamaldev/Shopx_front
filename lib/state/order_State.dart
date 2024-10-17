import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopx/models/order.dart';
import 'dart:convert';

import 'package:shopx/state/dataStore/local_Storge.dart';

class OrderState with ChangeNotifier {
  List<order>? _order;
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
      // print(data);

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

  Future<bool> getoldOrders() async {
    var userToken = CacheNetwork.getFromCache(key: 'token');
    String url = 'http://10.0.2.2:8000/api/orderbyuser/';
    try {
      http.Response res = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token $userToken',
      });
      var data = json.decode(res.body) as Map;
      // print(data);
      List<order> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          order oldOrder = order.fromJson(element);
          demo.add(oldOrder);
        });
        _order = demo;
        notifyListeners();
        return true;
      } else {
        print(data['data']);
        return false;
      }
    } catch (e) {
      print("error getoldOrders $e");
      return false;
    }
  }

  List<order>? get oldorder {
    if (_order != null) {
      return [..._order!];
    } else {
      return null;
    }
  }
}

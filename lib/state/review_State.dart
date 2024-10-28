import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopx/models/review.dart';
import 'package:shopx/state/dataStore/local_Storge.dart';

class ReviewState with ChangeNotifier {
  List<Review> _review = [];

  Future<bool> fetchReviweData() async {
    var userToken = CacheNetwork.getFromCache(key: 'token');

    String url = 'http://10.0.2.2:8000/api/review/';
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        'Authorization': "token $userToken"
      });

      var data = json.decode(response.body) as List;
      List<Review> temp = [];
      data.forEach((element) {
        Review review = Review.fromJson(element);
        temp.add(review);
      });
      _review = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print('e on fetchReviweData : $e');
      return false;
    }
  }

  Future<bool> reivewcreate(
      {required int uid,
      required String subject,
      required String commint,
      required int point,
      required String productid}) async {
    String url = 'http://10.0.2.2:8000/api/review-create/';
    var userToken = CacheNetwork.getFromCache(key: 'token');

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $userToken"
          },
          body: json.encode({
            "user": uid,
            "subject": subject,
            "commint": commint,
            "review_point": point,
            "product": productid
          }));

      var data = json.decode(response.body) as Map;
      print(data);
      if (data['error'] == false) {
        //whene false in server it mean true
        return true;
      }
      // print(data);
      return false;
    } catch (e) {
      print("e reivewcreate");
      print(e);
      return false;
    }
  }

  List<Review> get reviewes {
    return [..._review];
  }
}

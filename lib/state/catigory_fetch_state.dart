import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopx/models/category.dart';

class CatigoryFetchState with ChangeNotifier {
  List<Category> _category = [];
  Future<bool> getCategory() async {
    String url = 'http://10.0.2.2:8000/api/category/';

    try {
      http.Response res = await http.get(
        Uri.parse(url),
      );
      var data = json.decode(res.body) as List;
      // print(data);
      List<Category> demo = [];

      data.forEach((element) {
        Category category = Category.fromJson(element);
        demo.add(category);
      });
      _category = demo;
      notifyListeners();
      return true;
    } catch (e) {
      print('e on get CAtegory');
      print(e);
      return false;
    }
  }

  List<Category> get categoriesx {
    return [..._category];
  }
}

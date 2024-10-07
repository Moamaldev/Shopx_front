import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopx/models/product.dart';
import 'dart:convert';
import 'package:shopx/state/dataStore/local_Storge.dart';

class ProductState with ChangeNotifier {
  List<Product> _products = [];
  Future<bool> getProducts() async {
    var userToken = CacheNetwork.getFromCache(key: 'token');

    String url = 'http://10.0.2.2:8000/api/products/';
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        'Authorization': "token $userToken"
      });
      var data = json.decode(response.body) as List;
      // print(data);
      List<Product> demo = [];
      data.forEach((el) {
        Product product = Product.fromJson(el);
        demo.add(product);
      });

      _products = demo;
      notifyListeners();

      return true;
    } catch (e) {
      print("e getProducts :$e ");
      return false;
    }
  }

  Future<void> favoritBtn(String? id) async {
    var userToken = CacheNetwork.getFromCache(key: 'token');

    String url = 'http://10.0.2.2:8000/api/favorit/';
    try {
      // ignore: unused_local_variable
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $userToken"
          },
          body: json.encode({
            'id': id,
          }));
      // var data = json.decode(response.body);
      // print(data);
      getProducts();
    } catch (e) {
      print("e favoritBtn :$e ");
    }
  }

  List<Product> get productx {
    return [..._products];
  }

  Product singelProduct(String id) {
    return _products.firstWhere((el) => el.id == id);
  }

  List<Product> filterProductsByCategory(String categoryId) {
    return _products
        .where((product) => product.catagory?.id == categoryId)
        .toList();
  }

  List<Product> get favoritesProducts {
    return _products.where((product) => product.favorit == true).toList();
  }
}

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopx/models/product.dart';

class Cartx extends GetxController {
  final _product = {}.obs;

// addproduct
  void addproduct(Product product) {
    if (_product.containsKey(product)) {
      _product[product] += 1;
    } else {
      _product[product] = 1;
    }
  }

// deletproducts
  void deletproducts(Product product) {
    if (_product.containsKey(product) && _product[product] >= 1 ||
        _product[product] == 1) {
      //  حذف المنتج مهما كانت الكمية
      _product.removeWhere((key, value) => key == product);
    }
  }

// deletall
  void deletall(Product product) {
    if (_product.containsKey(product)) {
      _product.removeWhere((key, value) => key == product);
    }
  }

//deletproduct mit if
  void deletproduct(Product product) {
    if (_product.containsKey(product) && _product[product] == 1) {
      // الحذف حسب الكمية
      _product.removeWhere((key, value) => key == product);
    } else {
      _product[product] -= 1; // اذا لا نقص الفاليو او الكميه واحد
    }
  }

  int get count {
    return _product.length;
  }

  get cartItems => _product;

  get subtotal => _product.entries
      .map((product) => product.key.sellingPrice * product.value)
      .toList();

  get total => _product.entries.isNotEmpty
      ? _product.entries
          .map((product) => product.key.sellingPrice * product.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2)
      : '0.00';
//StateError (Bad state: No element) resolve done
  void clear() {
    _product.clear();
  }
}

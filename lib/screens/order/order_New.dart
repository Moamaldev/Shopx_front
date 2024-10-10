import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopx/state/cart_Getx.dart';

class OrderScreen extends StatefulWidget {
  final String total;
  final List<String> item;

  const OrderScreen({super.key, required this.total, required this.item});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

final Cartx cartx = Get.find();

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

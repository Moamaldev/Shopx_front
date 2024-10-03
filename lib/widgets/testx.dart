// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopx/state/product_State.dart';

// class Testx extends StatefulWidget {
//   final String id;
//   const Testx({Key? key, required this.id}) : super(key: key);

//   @override
//   State<Testx> createState() => _TestxState(catid: id);
// }

// class _TestxState extends State<Testx> {
//   final String catid;
//   bool _init = true;
//   bool _isloding = false;

//   _TestxState({required this.catid});
//   @override
//   void didChangeDependencies() async {
//     // أول ما يشتغل التطبيق ينفذ البروفايدر ستيت
//     if (_init) {
//       _isloding = await Provider.of<ProductState>(context).getProducts();
//       setState(() {});
//     }
//     _init = false;
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productx = Provider.of<ProductState>(context)
//         .filterProductsByCategory("3e872daa-9a03-45d3-8750-2ad1c0694bcf");

//     return Container(
//       height: 100,
//       width: 100,
//       child: Consumer<CategoryProvider>(builder: (context, categoryProvider, child) => ,),
//     );
//   }
// }

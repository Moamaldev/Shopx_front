import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/state/product_State.dart';
import 'package:shopx/style.dart';
import 'package:shopx/widgets/singel_Product.dart';

class AllProductScreen extends StatefulWidget {
  static const routename = '/view_all';

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  bool _innit = true;
  bool _isLoding = false;
  @override
  void didChangeDependencies() async {
    if (_innit) {
      _isLoding = await Provider.of<ProductState>(context).getProducts();
      setState(() {});
    }
    _innit = false;

    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final product = Provider.of<ProductState>(context).productx;

    if (!_isLoding) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()) // حالة التحميل
          );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: standardPaddingX,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: product.length,
              itemBuilder: (ctx, index) => SingelProduct(
                    productName: product[index].titel as String,
                    img: product[index].img as String,
                    price: product[index].sellingPrice as int,
                    id: product[index].id as String,
                    ctx: context,
                    fav: product[index].favorit as bool,
                  )),
        ),
      );
    }
  }
}

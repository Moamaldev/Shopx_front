import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shopx/animation/fade_Animaton.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/config/size_config.dart';
import 'package:shopx/state/product_State.dart';
import 'package:shopx/widgets/customDrawer.dart';
import 'package:shopx/widgets/singel_Product.dart';

class AllProductScreen extends StatelessWidget {
  static const routename = '/view_all';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductState>(context).productx;
    if (product.isEmpty) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()) // حالة التحميل
          );
    } else {
      return Scaffold(
        key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
        drawer: CustomDrawer(),
        backgroundColor: AppColors.white,

        appBar: AppBar(
          automaticallyImplyLeading: false, // يوخر التحكم من الاب بار
          centerTitle: false,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: RawMaterialButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 11.0),
                  constraints: const BoxConstraints(
                    minWidth: 10,
                  ),
                  fillColor: AppColors.white,
                  child: SvgPicture.asset(
                    "assets/menu.svg",
                    // ignore: deprecated_member_use
                    color: AppColors.black,
                    width: 20,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.screenWidth / 6,
              ),
              const FadeAnimation(
                0.9,
                Text('All Products'),
              )
            ],
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(25),
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

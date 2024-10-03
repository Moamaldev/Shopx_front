import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/config/size_config.dart';
import 'package:shopx/screens/product_DetailScren.dart';
import 'package:shopx/state/product_State.dart';
import 'package:shopx/style.dart';

class SingelProduct extends StatelessWidget {
  final String productName, img, id;
  final int price;
  final BuildContext ctx;
  final bool fav;
  const SingelProduct({
    super.key,
    required this.productName,
    required this.img,
    required this.price,
    required this.id,
    required this.ctx,
    required this.fav,
  });

  @override
  Widget build(ctx) {
    return GestureDetector(
      onTap: () {
        // print(id);
        Navigator.of(ctx)
            .pushNamed(ProductDetailScreen.routename, arguments: id);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: (SizeConfig.screenWidth - 80) / 2,
        height: SizeConfig.blockSizeVertical * 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage('http://10.0.2.2:8000$img'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        text: productName,
                        color: AppColors.textGray,
                        size: 16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      PrimaryText(
                        text: '\$${price}',
                        fontWeight: FontWeight.w900,
                        color: AppColors.black,
                        size: 16,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: RawMaterialButton(
                      autofocus: true,
                      constraints: BoxConstraints(minWidth: 0, minHeight: 0),
                      onPressed: () {
                        Provider.of<ProductState>(ctx, listen: false)
                            .favoritBtn(id);
                      },
                      child: fav
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 25,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                      padding: EdgeInsets.all(3),
                      shape: CircleBorder(),
                      // fillColor: AppColors.primary,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

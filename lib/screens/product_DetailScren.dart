import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/config/size_config.dart';
import 'package:shopx/screens/Review/review_Screen.dart';
import 'package:shopx/screens/cart_Screen.dart';
import 'package:shopx/state/cart_Getx.dart';
import 'package:shopx/style.dart';
import 'package:badges/badges.dart' as badges;
import '../state/product_State.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routename = '/product_details_screen';
  final cartx = Get.put(Cartx());

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final product =
        Provider.of<ProductState>(context).singelProduct(id as String);

    return Obx(
      () => Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.amberAccent,
        //   title: const Text("Product Details"),
        // ),
        // body: Center(
        //   child: Text(id),
        // ),

        //***** add to cart btn *****
        floatingActionButton: Padding(
          padding: standardPaddingX,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //add to cart
              ElevatedButton(
                onPressed: () {
                  cartx.addproduct(product);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15)),
                child: PrimaryText(
                    text: "Add To Cart", color: AppColors.white, size: 18),
              ),

              //fav btn
              RawMaterialButton(
                  onPressed: () {
                    Provider.of<ProductState>(context, listen: false)
                        .favoritBtn(product.id);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  constraints: const BoxConstraints(
                    minWidth: 2,
                  ),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  child: product.favorit!
                      ? const Icon(
                          Icons.favorite,
                          color: AppColors.primary,
                          size: 30,
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                          color: AppColors.black,
                          size: 30,
                        )),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          height: SizeConfig.screenHeight,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: SizeConfig.screenHeight / 1.7,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage('http://10.0.2.2:8000${product.img}'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: EdgeInsets.only(top: 50, left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 3,
                        child: RawMaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            constraints: const BoxConstraints(
                              minWidth: 2,
                            ),
                            fillColor: AppColors.white,
                            child: Icon(
                              Icons.chevron_left,
                              color: AppColors.black,
                              size: 30,
                            )),
                      ),

                      //********cart icon******* */
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 3,
                        child: RawMaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(Cart.routename);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            constraints: const BoxConstraints(
                              minWidth: 2,
                            ),
                            fillColor: AppColors.white,
                            child: cartx.count == 0
                                ? const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: AppColors.black,
                                    size: 30,
                                  )
                                : badges.Badge(
                                    position: badges.BadgePosition.topStart(
                                        top: -20, start: -20),
                                    badgeContent: Text(
                                      cartx.count.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    showBadge: true,
                                    child: const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: AppColors.primary,
                                      size: 30,
                                    ))),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                transform: Matrix4.translationValues(0, -30, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: AppColors.white,
                ),
                width: SizeConfig.screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Center(
                      child: Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2.5,
                    ),
                    PrimaryText(
                      text: product.titel as String,
                      size: 28,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                          text: '\$${product.sellingPrice}.00',
                          color: AppColors.primary,
                          size: 33,
                          fontWeight: FontWeight.w900,
                        ),
                        //***** kommentare btn **** */
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                ReviewScreen.routename,
                                arguments: id);
                            // Navigator.of(context)
                            //     .pushReplacementNamed(ReviewScreen.routename);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryLight,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PrimaryText(
                                  text: "Reviwers",
                                  color: AppColors.primary,
                                  size: 18),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.mode_comment_rounded,
                                color: Colors.purple,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2.5,
                    ),
                    PrimaryText(
                      text: '${product.description}',
                      color: AppColors.textGray,
                      size: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/config/size_config.dart';
import 'package:shopx/screens/all_Product_Screen.dart';
import 'package:shopx/state/catigory_fetch_state.dart';
import 'package:shopx/state/product_State.dart';
import 'package:shopx/style.dart';
import 'package:shopx/widgets/singel_Product.dart';

class HomeScreen extends StatefulWidget {
  static const routename = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCat = 0;
  // List selectedCategoryList=[];
  // List cat = [];
  bool _innit = true;
  bool _isLoding = false;
  // bool _isLoding2 = false;

  @override
  void didChangeDependencies() async {
    if (_innit) {
      _isLoding = await Provider.of<CatigoryFetchState>(context)
              .getCategory() &&
          await Provider.of<ProductState>(context, listen: false).getProducts();

      // _isLoding2 =
      //     // ignore: use_build_context_synchronously
      //     await Provider.of<ProductState>(context, listen: false).getProducts();

      setState(() {});
    }
    _innit = false;

    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final category = Provider.of<CatigoryFetchState>(context).categoriesx;

    if (!_isLoding) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Welcome to Shop"),
          ),
          body: Center(child: CircularProgressIndicator()) // حالة التحميل
          );
    } else {
      final productx = Provider.of<ProductState>(context)
          .filterProductsByCategory('${category[selectedCat].id}');
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RawMaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 11.0),
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
          elevation: 0,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Padding(
              padding: standardPaddingX,
              child: PrimaryText(
                  text: 'Discover your best furniture',
                  fontWeight: FontWeight.w700,
                  size: 36),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            // search
            Padding(
              padding: standardPaddingX,
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                        color: AppColors.textGray,
                        fontSize: 18),
                    prefixIcon: const Icon(Icons.search,
                        size: 30, color: AppColors.black)),
              ),
            ),

            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),

            // cat
            SizedBox(
              height: SizeConfig.blockSizeVertical * 7.5,
              child: ListView.builder(
                itemCount: category.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.only(
                    left: index == 0 ? 25 : 0,
                    right: 20,
                  ),
                  child: ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCat = index;
                          // selectedCategoryList = cat
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: selectedCat == index
                              ? AppColors.primary
                              : Colors.grey.shade200),
                      child: PrimaryText(
                        text: category[index].titel as String,
                        color: selectedCat == index
                            ? AppColors.white
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),

            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),

            Padding(
              padding: standardPaddingX,
              child: Row(
                children: [
                  PrimaryText(
                      text: 'Popular', fontWeight: FontWeight.w800, size: 28),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AllProductScreen.routename);
                    },
                    child: PrimaryText(
                        text: 'View all',
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        size: 20),
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2.2,
            ),
            // filter product
            // Padding(
            //   padding: standardPaddingX,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: List.generate(
            //         productx.length,
            //         (index) => SingelProduct(
            // productName: productx[index].titel as String,
            // img: productx[index].img as String,
            // price: productx[index].sellingPrice as int,
            // id: productx[index].id as String,
            // ctx: context,
            //             )),
            //   ),
            // ),

            Container(
              height: SizeConfig.blockSizeVertical * 30,
              child: Padding(
                padding: standardPaddingX,
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Align items to the start

                            children: List.generate(
                                productx.length,
                                (index) => productx.length > 0
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: SingelProduct(
                                          productName:
                                              productx[index].titel as String,
                                          img: productx[index].img as String,
                                          price: productx[index].sellingPrice
                                              as int,
                                          id: productx[index].id as String,
                                          ctx: context,
                                          fav: productx[index].favorit as bool,
                                        ),
                                      )
                                    : SizedBox(
                                        width: 0,
                                      ))),
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}

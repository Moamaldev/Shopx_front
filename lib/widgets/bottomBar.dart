import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/config/size_config.dart';
import 'package:shopx/screens/cart_Screen.dart';
import 'package:shopx/screens/favorite_Screen.dart';
import 'package:shopx/screens/home_Screen.dart';
import 'package:shopx/screens/profile.dart';
import 'package:shopx/style.dart';

class BottomBar extends StatefulWidget {
  static const routename = '/bottom_screen';

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  final tabs = [
    HomeScreen(),
    FavoriteScreen(),
    // LoginScreen(),
    Cart(
      check: true,
    ),
    UserProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // final username = Provider.of<FetchSingelUser>(context).

    SizeConfig().init(context);
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: AppColors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setBottomBarIndex(0);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentIndex == 0
                          ? AppColors.primaryLight
                          : AppColors.white),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/home.svg',
                        width: 20,
                        color: currentIndex == 0
                            ? AppColors.primary
                            : AppColors.iconGray,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      currentIndex == 0
                          ? PrimaryText(
                              text: 'Home',
                              size: 16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700)
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setBottomBarIndex(1);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentIndex == 1
                          ? AppColors.primaryLight
                          : AppColors.white),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: currentIndex == 1
                            ? AppColors.primary
                            : AppColors.iconGray,
                        size: currentIndex == 1 ? 20 : 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      currentIndex == 1
                          ? PrimaryText(
                              text: 'Favorites',
                              size: 16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700)
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setBottomBarIndex(2);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentIndex == 2
                          ? AppColors.primaryLight
                          : AppColors.white),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/cart.svg',
                        width: 20,
                        color: currentIndex == 2
                            ? AppColors.primary
                            : AppColors.iconGray,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      currentIndex == 2
                          ? PrimaryText(
                              text: 'Cart',
                              size: 16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700)
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setBottomBarIndex(3);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentIndex == 3
                          ? AppColors.primaryLight
                          : AppColors.white),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/user.svg',
                        width: 20,
                        color: currentIndex == 3
                            ? AppColors.primary
                            : AppColors.iconGray,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      currentIndex == 3
                          ? PrimaryText(
                              text: 'Profile',
                              size: 16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700)
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

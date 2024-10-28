import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/screens/auth/login_Screen.dart';
import 'package:shopx/screens/cart_Screen.dart';
import 'package:shopx/screens/favorite_Screen.dart';
import 'package:shopx/screens/order/order_History.dart';
import 'package:shopx/state/dataStore/local_Storge.dart';
import 'package:shopx/state/fetch_Singel_user.dart';
import 'package:shopx/widgets/bottomBar.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FetchSingelUser>(context).user;
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Custom Drawer Header
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryLight,
                  AppColors.primary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/chair-1.png'), // Custom profile image
                ),
                SizedBox(height: 10),
                Text(
                  '${user!.firstName}',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.email}',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Drawer Body
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(BottomBar.routename);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.favorite,
                  text: 'Favorite',
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(FavoriteScreen.routename);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.history_sharp,
                  text: 'Order History',
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(OrderHistory.routename);
                  },
                ),
                Divider(),
                _buildDrawerItem(
                  icon: Icons.shopping_cart,
                  text: 'Shopping Cart',
                  onTap: () {
                    Navigator.of(context).pushNamed(Cart.routename);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () async {
                    await CacheNetwork.deletFromCache(key: 'token');
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routename);

                    // delet token next time muss man wider mal login oder register
                    //clear ist besser aber habe ich nur 1 str
                    // Implement your logout logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDrawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    leading: Icon(
      icon,
      color: AppColors.primary,
    ),
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    onTap: onTap,
  );
}

import 'package:flutter/material.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/screens/favorite_Screen.dart';
import 'package:shopx/widgets/bottomBar.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/chair-1.png'), // Custom profile image
                ),
                SizedBox(height: 10),
                Text(
                  'Alex Johnson',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'alex.j@example.com',
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
                  icon: Icons.notifications,
                  text: 'Notifications',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                _buildDrawerItem(
                  icon: Icons.settings,
                  text: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {
                    Navigator.pop(context);
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

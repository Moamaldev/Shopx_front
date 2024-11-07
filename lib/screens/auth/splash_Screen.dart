import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/screens/auth/login_Screen.dart';
import 'package:shopx/state/dataStore/constant_Var.dart';
import 'package:shopx/widgets/bottomBar.dart';

class SplashScreen extends StatefulWidget {
  static const routename = '/splash-screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(
        context,
        token != null && token != ''
            ? BottomBar.routename
            : LoginScreen.routename,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/shopx.json', width: 200, height: 200),
            SizedBox(height: 20),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    'Welcome to ShopX',
                    textStyle: TextStyle(color: AppColors.black),
                    duration: Duration(seconds: 4),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

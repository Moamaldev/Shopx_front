import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/screens/all_Product_Screen.dart';
import 'package:shopx/screens/auth/login_Screen.dart';
import 'package:shopx/screens/auth/rigester_Screen.dart';
import 'package:shopx/screens/cart_Screen.dart';
import 'package:shopx/screens/favorite_Screen.dart';
import 'package:shopx/screens/home_Screen.dart';
import 'package:shopx/screens/order/order_History.dart';
import 'package:shopx/screens/product_DetailScren.dart';
import 'package:shopx/state/catigory_fetch_state.dart';
import 'package:shopx/state/dataStore/constant_Var.dart';
import 'package:shopx/state/dataStore/local_Storge.dart';
import 'package:shopx/state/fetch_Singel_user.dart';
import 'package:shopx/state/order_State.dart';
import 'package:shopx/state/product_State.dart';
import 'package:shopx/state/user_State.dart';
import 'package:shopx/widgets/bottomBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ميشغل التطبيق قبل ذني
  await CacheNetwork.cacheInitialization(); // init when app run
  token = CacheNetwork.getFromCache(key: 'token');
  print("token is $token");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductState()),
        ChangeNotifierProvider(create: (ctx) => CatigoryFetchState()),
        ChangeNotifierProvider(create: (ctx) => UserState()),
        ChangeNotifierProvider(create: (ctx) => FetchSingelUser()),
        ChangeNotifierProvider(create: (ctx) => OrderState())
      ],
      child: MaterialApp(
        routes: {
          LoginScreen.routename: (ctx) => LoginScreen(),
          RigesterScreen.routename: (ctx) => RigesterScreen(),
          HomeScreen.routename: (ctx) => HomeScreen(),
          ProductDetailScreen.routename: (ctx) => ProductDetailScreen(),
          AllProductScreen.routename: (ctx) => AllProductScreen(),
          FavoriteScreen.routename: (ctx) => FavoriteScreen(),
          BottomBar.routename: (ctx) => BottomBar(),
          Cart.routename: (ctx) => Cart(
                check: false, // check mean back btn
              ),
          OrderHistory.routename: (ctx) => OrderHistory(),
        },
        title: 'Shopx',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: token != null && token != '' ? BottomBar() : LoginScreen(),

        // home: BottomBar(),
      ),
    );
  }
}

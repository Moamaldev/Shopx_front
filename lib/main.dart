import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/screens/all_Product_Screen.dart';
import 'package:shopx/screens/home_Screen.dart';
import 'package:shopx/screens/product_DetailScren.dart';
import 'package:shopx/state/catigory_fetch_state.dart';
import 'package:shopx/state/product_State.dart';
import 'package:shopx/widgets/bottomBar.dart';

void main() {
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
        ChangeNotifierProvider(create: (ctx) => CatigoryFetchState())
      ],
      child: MaterialApp(
          routes: {
            HomeScreen.routename: (ctx) => HomeScreen(),
            ProductDetailScreen.routename: (ctx) => ProductDetailScreen(),
            AllProductScreen.routename: (ctx) => AllProductScreen(),
          },
          title: 'Shopx',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BottomBar()),
    );
  }
}

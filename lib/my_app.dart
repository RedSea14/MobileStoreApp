import 'package:appbanhang/pages/auth/login.dart';
import 'package:appbanhang/pages/card/cart.dart';
import 'package:appbanhang/pages/category/category.dart';
import 'package:appbanhang/pages/home/home.dart';
import 'package:appbanhang/pages/order/order.dart';
import 'package:appbanhang/pages/product/product.dart';
import 'package:appbanhang/provider/auth_provider.dart';
import 'package:appbanhang/provider/cart_provider.dart';
import 'package:appbanhang/provider/category_provider.dart';
import 'package:appbanhang/provider/order_provider.dart';
import 'package:appbanhang/provider/product_provider.dart';
import 'package:appbanhang/provider/silder_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _nameState();
}

// ignore: camel_case_types
class _nameState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SliderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(builder: (context, auth, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // ignore: dead_code
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            CategoryPage.routename: (context) => const CategoryPage(),
            ProductPage.routerName: (context) => const ProductPage(),
            CartPage.routeName: (context) => const CartPage(),
            LoginPage.routeName: (context) => const LoginPage(),
            Order.routeName: (context) => const Order(),
          },
        );
      }),
    );
  }
}

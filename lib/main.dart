import 'package:cr_shop_app/providers/products_provider.dart';
import 'package:cr_shop_app/screens/cart_screen.dart';
import 'package:cr_shop_app/screens/product_detail_screen.dart';
import 'package:cr_shop_app/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.orange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName : (context) => ProductDetailScreen(''),
          CartScreen.routeName : (context) => CartScreen(),
        },
      ),
    );
  }
}

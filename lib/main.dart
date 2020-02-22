import 'package:cr_shop_app/providers/auth_provider.dart';
import 'package:cr_shop_app/providers/orders_provider.dart';
import 'package:cr_shop_app/providers/products_provider.dart';
import 'package:cr_shop_app/screens/auth_screen.dart';
import 'package:cr_shop_app/screens/cart_screen.dart';
import 'package:cr_shop_app/screens/edit_product_screen.dart';
import 'package:cr_shop_app/screens/orders_screen.dart';
import 'package:cr_shop_app/screens/product_detail_screen.dart';
import 'package:cr_shop_app/screens/products_overview_screen.dart';
import 'package:cr_shop_app/screens/splash_screen.dart';
import 'package:cr_shop_app/screens/user_products_screen.dart';
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
          value: AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          // create: (ctx) => ProductsProvider(),
          builder: (ctx, auth, previousProducts) => ProductsProvider(
              auth.token,
              previousProducts == null ? [] : previousProducts.items,
              auth.userId),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          builder: (ctx, auth, previousOrders) => OrdersProvider(auth.token,
              previousOrders == null ? [] : previousOrders.orders, auth.userId),
        )
        /*ChangeNotifierProvider.value(
          value: OrdersProvider(),
        ),*/
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.orange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          /* initialRoute: auth.isAuth
              ? ProductsOverviewScreen.routeName
              : AuthScreen.routeName,*/
          routes: {
            AuthScreen.routeName: (context) => AuthScreen(),
            ProductsOverviewScreen.routeName: (context) =>
                ProductsOverviewScreen(),
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}

import 'package:cr_shop_app/providers/orders_provider.dart';
import 'package:cr_shop_app/widgets/app_drawer.dart';
import 'package:cr_shop_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersPovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, index) => OrderItem(
            orderData.orders[index],
          )),
      drawer: AppDrawer(),
    );
  }
}

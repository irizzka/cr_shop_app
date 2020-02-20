import 'package:cr_shop_app/providers/orders_provider.dart';
import 'package:cr_shop_app/widgets/app_drawer.dart';
import 'package:cr_shop_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order';


  @override
  Widget build(BuildContext context) {
    print('orders build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSetOrders(),
        builder: (ctx, dataSnaphot) {
          if (dataSnaphot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnaphot.error != null) {
              print(dataSnaphot.error.toString());
              return Center(child: Text('ooops error occurred'),);
            } else {
              return Consumer<OrdersProvider>(
                builder: (context, order, child) => ListView.builder(
                    itemCount: order.orders.length,
                    itemBuilder: (context, index) => OrderItem(
                      order.orders[index],
                        )),
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}

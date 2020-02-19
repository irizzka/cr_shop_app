import 'package:cr_shop_app/models/cart_item.dart';
import 'package:cr_shop_app/models/order_item.dart';
import 'package:flutter/cupertino.dart';

class OrdersPovider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders]; // copy of _orders
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(0, OrderItem(
      id: DateTime.now().toString(),
      amount: total,
      dateTime: DateTime.now(),
      products: cartProducts,
    ));
    notifyListeners();
  }

}
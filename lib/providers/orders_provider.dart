import 'dart:convert';

import 'package:cr_shop_app/models/cart_item.dart';
import 'package:cr_shop_app/models/order_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String authToken;
  final String userId;

  OrdersProvider(this.authToken, this._orders, this.userId);

  List<OrderItem> get orders {
    return [..._orders]; // copy of _orders
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async{

    final String url = 'https://cr-shop-app.firebaseio.com/orders/$userId.json?auth=$authToken';

    final DateTime timestamp = DateTime.now();
    final http.Response response = await http.post(url, body: json.encode({
      'amount' : total,
      'dateTime' : timestamp.toIso8601String(),
      'products' : cartProducts.map((el) => {
        'id' : el.id,
        'title' : el.title,
        'quantity' : el.quantity,
        'price' : el.price,
      }).toList(),
    }));
    if(response.statusCode >= 400){
      
    }
    _orders.insert(0, OrderItem(
      id: json.decode(response.body)['name'],
      amount: total,
      dateTime: DateTime.now(),
      products: cartProducts,
    ));
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async{
    final String url = 'https://cr-shop-app.firebaseio.com/orders/$userId.json?auth=$authToken';

    http.Response response = await http.get(url);
    if(response.statusCode >= 400){
      throw ' error in fetchOrder';
    }

    final _extractedData = json.decode(response.body) as Map<String, dynamic>;
    if(_extractedData  == null){
      return;
    }
    final List<OrderItem> _loadedOrders = [];
    _extractedData.forEach((key, value){
      _loadedOrders.add(OrderItem(
        id: key,
        amount: value['amount'],
        dateTime: DateTime.parse(value['dateTime']),
        products: (value['products'] as List<dynamic>).map((el) => CartItem(
          id: el['id'],
          title: el['title'],
          price: el['price'],
          quantity: el['quantity'],
        )).toList(),
        ),
      );
    });
    _orders = _loadedOrders.reversed.toList();
    notifyListeners();
  }
}
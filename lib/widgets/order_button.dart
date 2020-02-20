import 'package:cr_shop_app/providers/cart_provider.dart';
import 'package:cr_shop_app/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderButton extends StatefulWidget {

  final CartProvider cart;


  OrderButton({this.cart});

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child:  Text('ORDER NOW'),
      textColor: Theme.of(context).primaryColor,
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading) ? null : () async{

        setState(() {
          _isLoading = true;
        });
        await Provider.of<OrdersProvider>(context, listen: false).addOrder(widget.cart.items.values.toList(), widget.cart.totalAmount);

        setState(() {
          _isLoading = false;
        });
        widget.cart.removeAll();
      },
    );
  }
}
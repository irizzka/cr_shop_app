import 'package:cr_shop_app/providers/product_provider.dart';
import 'package:cr_shop_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/details';
  final String _id;

  ProductDetailScreen(this._id);

  @override
  Widget build(BuildContext context) {
    final ProductProvider _currentProduct =
        Provider.of<ProductsProvider>(context).findById(_id);
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentProduct.title),
      ),
    );
  }
}

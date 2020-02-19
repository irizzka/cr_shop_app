import 'package:cr_shop_app/providers/product_provider.dart';
import 'package:cr_shop_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {

    final _routeAgrId = ModalRoute.of(context).settings.arguments as String;

    final ProductProvider _currentProduct =
       Provider.of<ProductsProvider>(context).findById(_routeAgrId);
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300.0,
              child: Image.network(_currentProduct.imageUrl, fit: BoxFit.cover,),
            ),
            SizedBox(height: 10,),
            Text('\$ ${_currentProduct.price}', style: TextStyle(
              color: Colors.grey, fontSize: 20,
            ),),
            SizedBox(height: 10.0,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(_currentProduct.description, textAlign: TextAlign.center, softWrap: true,)),
          ],
        ),
      ),
    );
  }
}

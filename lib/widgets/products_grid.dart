import 'package:cr_shop_app/providers/products_provider.dart';
import 'package:cr_shop_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {

  final bool _showOnlyFavorites;

  ProductsGrid(this._showOnlyFavorites);



  @override
  Widget build(BuildContext context) {

    final _productsData = Provider.of<ProductsProvider>(context);

    final _products = _showOnlyFavorites ? _productsData.favoriteItems :  _productsData.items;
    return GridView.builder(
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: _products[index],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _products.length,
      padding: const EdgeInsets.all(10),
    );
  }
}

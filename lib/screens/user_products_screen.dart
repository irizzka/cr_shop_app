import 'package:cr_shop_app/providers/products_provider.dart';
import 'package:cr_shop_app/screens/edit_product_screen.dart';
import 'package:cr_shop_app/widgets/app_drawer.dart';
import 'package:cr_shop_app/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }


  @override
  Widget build(BuildContext context) {
    print('user prod build');
  //  final _productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: _refreshProduct(context),
          //Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts(true),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                  onRefresh: () {
                   return _refreshProduct(context);
                //   Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts(true);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Consumer<ProductsProvider>(
                      builder: (ctx, product, child) =>ListView.builder(
                          itemCount: product.items.length,
                          itemBuilder: (ctx, index) => Column(
                                children: <Widget>[
                                  UserProductItem(
                                      product.items[index].title,
                                      product.items[index].imageUrl,
                                      product.items[index].id),
                                  Divider(),
                                ],
                              )),
                    ),
                  ));
            }
          }),
      drawer: AppDrawer(),
    );
  }
}

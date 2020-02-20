import 'package:cr_shop_app/providers/products_provider.dart';
import 'package:cr_shop_app/screens/edit_product_screen.dart';
import 'package:cr_shop_app/widgets/app_drawer.dart';
import 'package:cr_shop_app/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProduct(BuildContext context) async{
    await Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts();
  }



  @override
  Widget build(BuildContext context) {

    final _productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              //nav to add scr
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
         return _refreshProduct(context);
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: _productsData.items.length,
              itemBuilder: (ctx, index) => Column(
                children: <Widget>[
                  UserProductItem(_productsData.items[index].title,
                  _productsData.items[index].imageUrl, _productsData.items[index].id),
                  Divider(),
                ],
              )),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}

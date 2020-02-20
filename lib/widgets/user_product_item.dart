import 'package:cr_shop_app/providers/products_provider.dart';
import 'package:cr_shop_app/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String _id;
  final String _title;
  final String _imageUrl;

  UserProductItem(this._title, this._imageUrl, this._id);

  @override
  Widget build(BuildContext context) {
    final _scaff = Scaffold.of(context);
    return ListTile(
      title: Text(_title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: _id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .removeById(_id);
                } catch (e) {
                  _scaff.showSnackBar(
                    SnackBar(
                      content: Text('Deleting failed'),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

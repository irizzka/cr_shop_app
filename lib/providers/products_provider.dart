import 'package:cr_shop_app/providers/product_provider.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
   List<ProductProvider> _items = [ ProductProvider(
     id: 'p1',
     title: 'Red Shirt',
     description: 'A red shirt - it is pretty red!',
     price: 29.99,
     imageUrl:
     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
   ),
     ProductProvider(
       id: 'p2',
       title: 'Trousers',
       description: 'A nice pair of trousers.',
       price: 59.99,
       imageUrl:
       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
     ),
     ProductProvider(
       id: 'p3',
       title: 'Yellow Scarf',
       description: 'Warm and cozy - exactly what you need for the winter.',
       price: 19.99,
       imageUrl:
       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
     ),
     ProductProvider(
       id: 'p4',
       title: 'A Pan',
       description: 'Prepare any meal you want.',
       price: 49.99,
       imageUrl:
       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
     ),];

   List<ProductProvider> get favoriteItems {
     return _items.where((el) => el.isFavorite).toList();
   }


   List<ProductProvider> get items {

     return [..._items];
   }

   void addProduct(ProductProvider product) {
    // _items.add();
     final newProduct = ProductProvider(
       id: DateTime.now().toString(),
       price: product.price,
       description: product.description,
       imageUrl: product.imageUrl,
       title: product.title,
     );

     _items.add(newProduct);
     notifyListeners();
   }

   ProductProvider findById (String id){
     return _items.firstWhere((el) => el.id == id);
   }


   void removeById(String elementId) {
     _items.removeWhere((el)=> el.id == elementId);
     notifyListeners();
   }

   void updateById(String newId, ProductProvider newProduct){
     final prodIndex = _items.indexWhere((el)=> el.id == newId);
     if(prodIndex >= 0){
       _items[prodIndex] = newProduct;
       notifyListeners();
     }
   }
}
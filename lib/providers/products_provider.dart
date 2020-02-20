import 'package:cr_shop_app/models/http_exception.dart';
import 'package:cr_shop_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
   List<ProductProvider> _items = [
    /* ProductProvider(
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
     ),*/
   ];

   Future<void> fetchAndSetProducts () async{
     const url = 'https://cr-shop-app.firebaseio.com/products.json';
     try{
       http.Response response = await http.get(url);

       final _data = jsonDecode(response.body) as Map<String, dynamic>;
       if(_data == null){
         return;
       }
       final List<ProductProvider> _loadedProducts = [];
       _data.forEach((key, value){
         _loadedProducts.add(ProductProvider(
           id: key,
           title: value['title'],
           imageUrl: value['imageUrl'],
           description: value['description'],
           price: value['price'],
           isFavorite: value['isFavorite'],
         ));
       });
      _items = _loadedProducts;
       notifyListeners();
     }catch(error){
       throw (error);
     }
   }



   List<ProductProvider> get favoriteItems {
     return _items.where((el) => el.isFavorite).toList();
   }


   List<ProductProvider> get items {

     return [..._items];
   }

   Future<void> addProduct(ProductProvider product) async{
     //todo http
     const url = 'https://cr-shop-app.firebaseio.com/products.json';
     try {
       final response = await http.post(url, body: json.encode({
         'title': product.title,
         'description': product.description,
         'imageUrl': product.imageUrl,
         'price': product.price,
         'isFavorite': product.isFavorite,
       },),);
       final newProduct = ProductProvider(
         id: json.decode(response.body)['name'],
         price: product.price,
         description: product.description,
         imageUrl: product.imageUrl,
         title: product.title,
       );

       _items.add(newProduct);
       notifyListeners();
     } catch (error) {

        print(error);
     }

   }

   ProductProvider findById (String id){
     return _items.firstWhere((el) => el.id == id);
   }


   Future<void> removeById(String elementId) async{
      // optimistic update
     final url = 'https://cr-shop-app.firebaseio.com/products/$elementId.json';
     final existingProductIndex = _items.indexWhere((el)=> el.id == elementId);
     var existingProduct = _items[existingProductIndex];
     _items.removeAt(existingProductIndex);

     final response = await http.delete(url);

       if(response.statusCode >= 400){
         _items.insert(existingProductIndex, existingProduct);
         notifyListeners();
         throw HttpException('Could not delete product.');
       }
       existingProduct = null;

        _items.removeAt(existingProductIndex);
        notifyListeners();
     _items.removeWhere((el)=> el.id == elementId);
     notifyListeners();
   }

   Future<void> updateById(String newId, ProductProvider newProduct) async{

     final url = 'https://cr-shop-app.firebaseio.com/products/$newId.json';

     final prodIndex = _items.indexWhere((el)=> el.id == newId);
     if(prodIndex >= 0){
       try{
        await http.patch(url, body: jsonEncode({
           'title' : newProduct.title,
           'description' : newProduct.description,
           'price' : newProduct.price,
           'imageUrl' : newProduct.imageUrl,
         }));
       }catch(error){
         print(error);
       }
       _items[prodIndex] = newProduct;
       notifyListeners();
     }
   }
}
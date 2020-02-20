import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductProvider({
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void _setFavValue(bool newValue){
    isFavorite = newValue;
  }

  Future<void> toggleFavoriteStatus() async{
    // proper optimistic update part
    final bool oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try{
      final url = 'https://cr-shop-app.firebaseio.com/products/$id.json';
     final http.Response response = await http.patch(url, body: jsonEncode({
        'isFavorite' : isFavorite,
      },),);
     if(response.statusCode >= 400){
       _setFavValue(oldStatus);
     }
    }catch(error){
      _setFavValue(oldStatus);
    }
  }
}

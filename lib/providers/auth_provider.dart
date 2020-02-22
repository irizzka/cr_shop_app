import 'package:cr_shop_app/models/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    print('isAuth');
    return token != null;
  }

  String get token {
   // if(_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null){
      return _token;
  //  }
  //  return null;
  }

  String get userId {
    return _userId;
  }

  void logout() {
    _userId = null;
    _token = null;
    notifyListeners();
  }


  Future<void> _authenticate(String email, String password, String urlSegment) async{
    final String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBMyvKoV39RL4sj2eg7k9NPVjRAdDqPG-E';
    try{
      final http.Response response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if(responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }
      print(responseData);
      _token = responseData['idToken'];
      _userId = responseData['localId'];
    //  _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    }catch(error){
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async{
    return _authenticate(email, password, 'signInWithPassword');
  }
}
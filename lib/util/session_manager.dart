import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<List<dynamic>> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString('products');

    List<dynamic> products = [];
    if (localData != null) {
      products = jsonDecode(localData);
    }
    return products;
  }

  static Future<void> setProducts(List<dynamic> products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('products', jsonEncode(products));
  }
}

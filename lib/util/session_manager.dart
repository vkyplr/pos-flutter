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

  static Future<List<dynamic>> getBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString('bills');
    // await prefs.remove('bills');
    List<dynamic> bills = [];
    if (localData != null) {
      bills = jsonDecode(localData);
    }
    return bills;
  }

  static Future<void> setBills(List<dynamic> bills) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('bills', jsonEncode(bills));
  }
}

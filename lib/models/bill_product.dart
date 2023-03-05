import 'dart:convert';

import 'package:inventory/models/product.dart';

class BillProduct {
  Product? product;
  int? quantity;
  int? discount;

  BillProduct({
    this.product,
    this.quantity,
    this.discount,
  });

  factory BillProduct.fromJson(Map<String, dynamic> data) {
    return BillProduct(
      product: Product.fromJson(data['product']),
      quantity: int.parse(data['quantity'] ?? 0),
      discount: int.parse(data['discount'] ?? 0),
    );
  }

  String getProfit() {
    return ((product!.salePrice - product!.costPrice) - discount!).toString();
  }

  String getAmount() {
    return (product!.salePrice * quantity!).toString();
  }

  String getDiscountedAmount() {
    return ((product!.salePrice * quantity!) - discount!).toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product!.toJson(),
      'quantity': quantity.toString(),
      'discount': discount.toString(),
    };
  }
}

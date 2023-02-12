class Product {
  String name;
  int quantity;
  int costPrice;
  int salePrice;

  Product(
      {required this.name,
      required this.quantity,
      required this.costPrice,
      required this.salePrice});

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
        name: data['name'] ?? '',
        quantity: int.parse(data['quantity'] ?? 0),
        costPrice: int.parse(data['costPrice'] ?? 0),
        salePrice: int.parse(data['salePrice'] ?? 0));
  }

  String getProfit() {
    return (salePrice - costPrice).toString();
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'quantity': quantity.toString(),
      'costPrice': costPrice.toString(),
      'salePrice': salePrice.toString()
    };
  }
}

import 'package:inventory/models/bill_product.dart';

class Bill {
  List<BillProduct> billProducts;
  String customername;
  String customerPhone;
  String date;
  int billNo;

  Bill(
      {required this.billNo,
      required this.billProducts,
      required this.customername,
      required this.customerPhone,
      required this.date});

  factory Bill.fromJson(Map<String, dynamic> data) {
    List<BillProduct> p = [];
    for (int i = 0; i < data['billProducts'].length; ++i) {
      p.add(BillProduct.fromJson(data['billProducts'][i]));
    }
    return Bill(
        billNo: int.parse(data['billNo']),
        billProducts: p,
        customerPhone: data['customerPhone'],
        customername: data['customerName'],
        date: data['date']);
  }

  int getAmount() {
    int amount = 0;

    for (var element in billProducts) {
      amount += element.product!.salePrice;
    }

    return amount;
  }

  int getDiscountedAmount() {
    int amount = 0;
    int discount = 0;

    for (var element in billProducts) {
      if (element.product != null) {
        amount += (element.product!.salePrice * element.quantity!);
      }
    }

    for (var element in billProducts) {
      if (element.product != null) {
        discount += element.discount!;
      }
    }

    return amount - discount;
  }

  int getDiscount() {
    int discount = 0;

    for (var element in billProducts) {
      discount += element.discount!;
    }

    return discount;
  }

  int getQuantity() {
    int quantity = 0;

    for (var element in billProducts) {
      quantity += element.quantity!;
    }

    return quantity;
  }

  Map<String, dynamic> toJson() {
    List<dynamic> bpJson = billProducts.map((e) => e.toJson()).toList();
    return {
      'billNo': billNo.toString(),
      'billProducts': bpJson,
      'customerName': customername,
      'customerPhone': customerPhone,
      'date': date
    };
  }
}

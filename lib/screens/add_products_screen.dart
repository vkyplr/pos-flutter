import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/ui/app_colors.dart';
import 'package:inventory/ui/text_styles.dart';
import 'package:inventory/util/common_util.dart';
import 'package:inventory/util/session_manager.dart';
import 'package:sizer/sizer.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController costPrice = TextEditingController();
  TextEditingController salePrice = TextEditingController();

  String nameErrorText = '';
  String quantityErrorText = '';
  String costPriceErrorText = '';
  String salePriceErrorText = '';

  @override
  void initState() {
    name.addListener(() {
      nameErrorText = '';
      setState(() {});
    });

    quantity.addListener(() {
      quantityErrorText = '';
      setState(() {});
    });

    costPrice.addListener(() {
      costPriceErrorText = '';
      setState(() {});
    });

    salePrice.addListener(() {
      salePriceErrorText = '';
      setState(() {});
    });
    super.initState();
  }

  bool validateForm() {
    if (name.text.isEmpty) {
      nameErrorText = 'Name cannot be empty';
    } else {
      nameErrorText = '';
    }

    if (quantity.text.isEmpty) {
      quantityErrorText = 'Quantity cannot be empty';
    } else {
      quantityErrorText = '';
    }

    if (costPrice.text.isEmpty) {
      costPriceErrorText = 'Cost Price cannot be empty';
    } else {
      costPriceErrorText = '';
    }

    if (salePrice.text.isEmpty) {
      salePriceErrorText = 'Sale Price cannot be empty';
    } else {
      if (int.parse(salePrice.text) < int.parse(costPrice.text)) {
        salePriceErrorText = 'Sale Price cannot be less than cost price';
      } else {
        salePriceErrorText = '';
      }
    }

    setState(() {});

    return nameErrorText.isEmpty &&
        quantityErrorText.isEmpty &&
        salePriceErrorText.isEmpty &&
        costPriceErrorText.isEmpty;
  }

  void showSnackBarAndPop() {
    CommonUtil.showSnackBar(context, 'Product Added Successfully');
    Navigator.of(context).pop();
  }

  void addProduct() async {
    if (validateForm()) {
      Product product = Product(
          costPrice: int.parse(costPrice.text),
          salePrice: int.parse(salePrice.text),
          name: name.text,
          quantity: int.parse(quantity.text));
      List<dynamic> products = await SessionManager.getProducts();
      products.add(product.toJson());
      SessionManager.setProducts(products);
      showSnackBarAndPop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50.w,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.cardColor),
                child: Column(children: [
                  TextField(
                    controller: name,
                    cursorHeight: 20,
                    style: TextStyles.body5(),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: AppColors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.blue)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: AppColors.red)),
                        errorText: nameErrorText.isEmpty ? null : nameErrorText,
                        label: const Text(
                          'Product Name',
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        border: InputBorder.none),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: quantity,
                    cursorHeight: 20,
                    style: TextStyles.body5(),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: AppColors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.blue)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: AppColors.red)),
                        errorText: quantityErrorText.isEmpty
                            ? null
                            : quantityErrorText,
                        label: const Text(
                          'Quantity',
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        border: InputBorder.none),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: costPrice,
                    cursorHeight: 20,
                    style: TextStyles.body5(),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: AppColors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.blue)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: AppColors.red)),
                        errorText: costPriceErrorText.isEmpty
                            ? null
                            : costPriceErrorText,
                        label: const Text(
                          'Cost Price',
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        border: InputBorder.none),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: salePrice,
                    cursorHeight: 20,
                    style: TextStyles.body5(),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: AppColors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.blue)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: AppColors.red)),
                        errorText: salePriceErrorText.isEmpty
                            ? null
                            : salePriceErrorText,
                        label: const Text(
                          'Sale Price',
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        border: InputBorder.none),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20)),
                            onPressed: addProduct,
                            child: Text(
                              'Add Product',
                              style: TextStyles.body5()
                                  .copyWith(color: Colors.white),
                            )),
                      )
                    ],
                  )
                ]),
              )
            ],
          )),
    );
  }
}

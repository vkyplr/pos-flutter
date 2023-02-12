import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/ui/app_colors.dart';
import 'package:inventory/ui/text_styles.dart';
import 'package:inventory/util/common_util.dart';
import 'package:inventory/util/session_manager.dart';
import 'package:sizer/sizer.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Product> products = [];

  bool sort = true;
  bool sortQuantity = true;
  List<Product>? filterData;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.name.compareTo(b.name));
      } else {
        filterData!.sort((a, b) => b.name.compareTo(a.name));
      }
    }
  }

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  void getLocalData() async {
    List<dynamic> localData = await SessionManager.getProducts();
    products = [];
    for (var element in localData) {
      products.add(Product.fromJson(element));
    }
    filterData = products;
    setState(() {});
  }

  void onEdit(int index) {
    Product p = products[index];

    TextEditingController name = TextEditingController(text: p.name);
    TextEditingController quantity =
        TextEditingController(text: p.quantity.toString());
    TextEditingController costPrice =
        TextEditingController(text: p.costPrice.toString());
    TextEditingController salePrice =
        TextEditingController(text: p.salePrice.toString());

    String nameErrorText = '';
    String quantityErrorText = '';
    String costPriceErrorText = '';
    String salePriceErrorText = '';

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: StatefulBuilder(
              builder: (ctx, setBState) => Container(
                width: 50.w,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.cardColor),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                            onPressed: () {
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
                                costPriceErrorText =
                                    'Cost Price cannot be empty';
                              } else {
                                costPriceErrorText = '';
                              }

                              if (salePrice.text.isEmpty) {
                                salePriceErrorText =
                                    'Sale Price cannot be empty';
                              } else {
                                if (int.parse(salePrice.text) <
                                    int.parse(costPrice.text)) {
                                  salePriceErrorText =
                                      'Sale Price cannot be less than cost price';
                                } else {
                                  salePriceErrorText = '';
                                }
                              }

                              setBState(() {});

                              if (nameErrorText.isEmpty &&
                                  quantityErrorText.isEmpty &&
                                  salePriceErrorText.isEmpty &&
                                  costPriceErrorText.isEmpty) {
                                p.name = name.text;
                                p.quantity = int.parse(quantity.text);
                                p.salePrice = int.parse(salePrice.text);
                                p.costPrice = int.parse(costPrice.text);
                                List<Product> newProducts = [...products];
                                newProducts[index] = p;
                                List<Map<String, String>> newProductsJson = [];
                                for (Product product in newProducts) {
                                  newProductsJson.add(product.toJson());
                                }
                                SessionManager.setProducts(newProductsJson)
                                    .then((v) {
                                  getLocalData();
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                            child: Text(
                              'Update Product',
                              style: TextStyles.body5()
                                  .copyWith(color: Colors.white),
                            )),
                      )
                    ],
                  )
                ]),
              ),
            ),
          );
        });
  }

  void onDelete(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 50.w,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.cardColor),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  'Are you sure, you want to delete this product?',
                  textAlign: TextAlign.center,
                  style: TextStyles.body6(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20)),
                        child: Text('Cancle',
                            style: TextStyles.body5()
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          List<Product> newProducts = [...products];

                          List<Map<String, String>> newProductsJson = [];
                          newProducts.asMap().forEach((idx, element) {
                            if (index != idx) {
                              newProductsJson.add(element.toJson());
                            }
                          });
                          SessionManager.setProducts(newProductsJson).then((v) {
                            getLocalData();
                            Navigator.of(context).pop();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20)),
                        child: Text('Delete',
                            style: TextStyles.body5()
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Theme(
                    data: ThemeData.light()
                        .copyWith(cardColor: Theme.of(context).canvasColor),
                    child: PaginatedDataTable(
                      // sortColumnIndex: 0,
                      sortAscending: sort,
                      header: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: "Search By Name",
                              border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              products = filterData!
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                      ),
                      source: RowSource(
                          myData: products,
                          count: products.length,
                          onEdit: onEdit,
                          onDelete: onDelete),
                      // rowsPerPage: 10,
                      columnSpacing: 8,
                      columns: const [
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          // onSort: (columnIndex, ascending) {
                          //   setState(() {
                          //     sort = !sort;
                          //   });

                          //   onsortColum(columnIndex, ascending);
                          // }
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Quantity",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Cost Price",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Sale Price",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Profit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              "Actions",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class RowSource extends DataTableSource {
  final myData;
  final count;
  Function(int) onEdit;
  Function(int) onDelete;
  RowSource({
    required this.myData,
    required this.count,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], index, onEdit, onDelete);
    } else
      return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(
    var data, int index, Function(int) onEdit, Function(int) onDelete) {
  return DataRow(
    cells: [
      DataCell(Text(
        data.name ?? "Name",
      )),
      DataCell(Center(
        child: Text(
          data.quantity.toString(),
        ),
      )),
      DataCell(Center(
        child: Text(
          '\u{20B9} ${data.costPrice.toString()}',
        ),
      )),
      DataCell(Center(
        child: Text(
          '\u{20B9} ${data.salePrice.toString()}',
        ),
      )),
      DataCell(Center(
        child: Text(
          '\u{20B9} ${data.getProfit()}',
        ),
      )),
      DataCell(Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                onEdit(index);
              },
              child: const Text('Edit')),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              onDelete(index);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ]),
      )),
    ],
  );
}

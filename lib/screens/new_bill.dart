import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:inventory/models/bill.dart';
import 'package:inventory/models/bill_product.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/screens/bill_view.dart';
import 'package:inventory/screens/print_bill.dart';
import 'package:inventory/ui/app_colors.dart';
import 'package:inventory/ui/text_styles.dart';
import 'package:inventory/util/session_manager.dart';

class NewBill extends StatefulWidget {
  const NewBill({super.key});

  @override
  State<NewBill> createState() => _NewBillState();
}

class _NewBillState extends State<NewBill> {
  Bill bill = Bill(
      billNo: 0,
      billProducts: [BillProduct(quantity: 1, discount: 0)],
      customername: '',
      customerPhone: '',
      date: DateTime.now().toString());

  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerPhone = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat('dd MMM yyyy').format(DateTime.now()));
  FocusNode dateFocusNode = FocusNode();

  List<Product> products = [];
  List<TextEditingController> quantityControllers = [
    TextEditingController(text: '1')
  ];
  List<TextEditingController> discountControllers = [
    TextEditingController(text: '0')
  ];
  List<int> billProductIds = [0];

  void getLocalData() async {
    List<dynamic> localData = await SessionManager.getProducts();
    products = [];
    for (var element in localData) {
      products.add(Product.fromJson(element));
    }

    List<dynamic> bills = await SessionManager.getBills();
    bill.billNo = bills.length;
    setState(() {});
  }

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  void addProductToBill() {
    bill.billProducts.add(BillProduct(quantity: 1, discount: 0));
    quantityControllers.add(TextEditingController(text: '1'));
    discountControllers.add(TextEditingController(text: '0'));
    billProductIds.add(0);
    setState(() {});
  }

  void removeProductFromBill(int index) {
    List<BillProduct> newBillProducts = [];
    for (int i = 0; i < bill.billProducts.length; ++i) {
      if (index != i) {
        newBillProducts.add(bill.billProducts[i]);
      }
    }
    bill.billProducts = newBillProducts;
    quantityControllers.removeAt(index);
    discountControllers.removeAt(index);
    billProductIds.removeAt(index);
    setState(() {});
  }

  Future<List<Product>> searchProduct(String filterString) async {
    List<Product> searchProducts = [];
    List<Product> nonExistingProducts =
        products.where((e) => !billProductIds.contains(e.id)).toList();

    searchProducts = nonExistingProducts
        .where((element) =>
            element.name.toLowerCase().contains(filterString.toLowerCase()))
        .toList();
    return searchProducts;
  }

  List<Widget> billProductsControls() {
    List<Widget> controls = [];

    bill.billProducts.asMap().forEach((int index, BillProduct element) {
      controls.add(Row(
        children: [
          Expanded(
            child: DropdownSearch<Product>(
              popupProps: const PopupProps.menu(showSearchBox: true),
              asyncItems: (String filter) => searchProduct(filter),
              itemAsString: (Product p) => p.name,
              onChanged: (Product? data) {
                element.product = data;
                billProductIds[index] = data!.id;
                setState(() {});
              },
              selectedItem: element.product,
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: TextStyles.body6(),
                dropdownSearchDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    labelText: "Product Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: quantityControllers[index],
              cursorHeight: 20,
              onChanged: (value) {
                element.quantity = value != '' ? int.parse(value) : 0;
                setState(() {});
              },
              style: TextStyles.body6(),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                  suffixText: element.product != null
                      ? 'X \u{20B9}${element.product!.salePrice}'
                      : '',
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
                  // errorText: quantityErrorText.isEmpty ? null : quantityErrorText,

                  label: Text(
                    'Quantity ${element.product != null ? '(${element.product!.quantity})' : ''}',
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: InputBorder.none),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: discountControllers[index],
              cursorHeight: 20,
              onChanged: (value) {
                element.discount = value != '' ? int.parse(value) : 0;
                setState(() {});
              },
              style: TextStyles.body6(),
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
                  // errorText: quantityErrorText.isEmpty ? null : quantityErrorText,
                  label: const Text(
                    'Discount',
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: InputBorder.none),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          if (element.product != null)
            Expanded(
              child: Column(
                children: [
                  Text(
                    '(${element.quantity} X \u{20B9}${element.product!.salePrice}) - \u{20B9}${element.discount} = \u{20B9}${(element.quantity! * element.product!.salePrice) - element.discount!}',
                    style: TextStyles.body75(),
                  ),
                ],
              ),
            ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              removeProductFromBill(index);
            },
            style: ElevatedButton.styleFrom(
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                ),
                backgroundColor: Colors.red),
            child: const Icon(Icons.close),
          ),
        ],
      ));
      if (index != bill.billProducts.length - 1) {
        controls.add(const SizedBox(
          height: 20,
        ));
      }
    });
    return controls;
  }

  void unfocus() {
    dateFocusNode.unfocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> billProductsWithButton = [
      Row(children: [
        Expanded(
          child: TextField(
            controller: customerNameController,
            cursorHeight: 20,
            style: TextStyles.body6(),
            onChanged: (value) {
              bill.customername = value;
              setState(() {});
            },
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
                // errorText: quantityErrorText.isEmpty ? null : quantityErrorText,
                label: const Text(
                  'Customer Name',
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: InputBorder.none),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            controller: customerPhone,
            onChanged: (value) {
              bill.customerPhone = value;
              setState(() {});
            },
            cursorHeight: 20,
            style: TextStyles.body6(),
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
                // errorText: quantityErrorText.isEmpty ? null : quantityErrorText,
                label: const Text(
                  'Customer Phone',
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: InputBorder.none),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            controller: dateController,
            focusNode: dateFocusNode,
            onTap: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2100));
              if (date != null) {
                dateController.text = DateFormat('dd MMM yyyy').format(date);
                bill.date = date.toString();
              }
              unfocus();
            },
            cursorHeight: 20,
            style: TextStyles.body6(),
            inputFormatters: <TextInputFormatter>[
              TextInputFormatter.withFunction((oldValue, newValue) => oldValue)
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
                // errorText: quantityErrorText.isEmpty ? null : quantityErrorText,
                label: const Text(
                  'Date',
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: InputBorder.none),
          ),
        )
      ]),
      const Divider(
        height: 50,
      ),
      if (bill.billProducts.isNotEmpty)
        Text(
          'Bill Products',
          style: TextStyles.body4(),
        ),
      if (bill.billProducts.isNotEmpty)
        const SizedBox(
          height: 20,
        ),
      ...billProductsControls(),
      if (bill.billProducts.isNotEmpty &&
          (bill.billProducts.length < products.length))
        const SizedBox(
          height: 20,
        ),
      if (bill.billProducts.length < products.length)
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20)),
                onPressed: addProductToBill,
                child: Text(
                  'Add Product to Bill',
                  style: TextStyles.body6().copyWith(color: Colors.white),
                )),
          ],
        ),
      const SizedBox(
        height: 30,
      ),
      Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'Total Quantity',
                  style: TextStyles.body6(),
                ),
                Text(
                  bill.getQuantity().toString(),
                  style: TextStyles.body6(),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Total Discount',
                  style: TextStyles.body6(),
                ),
                Text(
                  '\u{20B9}${bill.getDiscount().toString()}',
                  style: TextStyles.body6(),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Total Amount',
                  style: TextStyles.body6(),
                ),
                Text(
                  '\u{20B9}${bill.getDiscountedAmount()}',
                  style: TextStyles.body6(),
                )
              ],
            ),
          ),
        ],
      )
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('New Bill'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.cardColor),
                  child: Column(
                    children: billProductsWithButton,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BillView(bill: bill),
                const SizedBox(
                  height: 20,
                ),
                if (bill.billProducts.isNotEmpty &&
                    bill.billProducts[0].product != null)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20)),
                      onPressed: () async {
                        List<dynamic> bills = await SessionManager.getBills();

                        bills.add(bill.toJson());
                        await SessionManager.setBills(bills);
                        navigateToPrintBill();
                      },
                      child: Text(
                        'Save & Print',
                        style: TextStyles.body6().copyWith(color: Colors.white),
                      )),
              ],
            )),
      ),
    );
  }

  void navigateToPrintBill() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PrintBillScreen(
                  bill: bill,
                )));
  }
}

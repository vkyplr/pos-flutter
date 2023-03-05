import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/models/bill.dart';
import 'package:inventory/models/bill_product.dart';
import 'package:inventory/ui/text_styles.dart';

class BillView extends StatelessWidget {
  const BillView({super.key, required this.bill});

  final Bill bill;

  Widget getBillView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Ashapura Medical and General Store',
                style: TextStyles.body4(),
              ),
              Text(
                'Opposite Namdev Kirana Store, Indra Colony, Phalodi',
                style: TextStyles.body75(),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer Name: ${bill.customername}',
                    style: TextStyles.body6(),
                  ),
                  Text(
                    'Customer Phone: ${bill.customerPhone}',
                    style: TextStyles.body6(),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bill No: ${bill.billNo}',
                    style: TextStyles.body6(),
                  ),
                  Text(
                    'Bill Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(bill.date))}',
                    style: TextStyles.body6(),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Table(
            border: TableBorder.all(width: 1.0, color: Colors.black),
            columnWidths: const {
              0: FractionColumnWidth(0.4),
              1: FractionColumnWidth(0.1),
              2: FractionColumnWidth(0.1),
              3: FractionColumnWidth(0.2),
              4: FractionColumnWidth(0.2),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Particulars',
                        style: TextStyles.body75()
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Qty',
                        style: TextStyles.body75()
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'MRP',
                        style: TextStyles.body75()
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Discount',
                        style: TextStyles.body75()
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, bottom: 8.0, right: 15),
                          child: Text(
                            'Amount',
                            style: TextStyles.body75()
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
              ...getBillParticulars(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Table(
            border: TableBorder.all(width: 1.0, color: Colors.black),
            columnWidths: const {
              0: FractionColumnWidth(0.8),
              1: FractionColumnWidth(0.2),
            },
            children: [
              TableRow(children: [
                TableCell(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Total',
                        style: TextStyles.body75()
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                )),
                TableCell(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0, right: 15),
                    child: Text(
                        '\u{20B9}${bill.getDiscountedAmount().toString()}',
                        style: TextStyles.body75()
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                ))
              ])
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Text(
                'Authorized Signatory',
                style: TextStyles.body6(),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBillView();
  }

  List<TableRow> getBillParticulars() {
    List<TableRow> billParticulars = [];
    for (BillProduct element in bill.billProducts) {
      if (element.product != null) {
        billParticulars.add(
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    element.product!.name,
                    style: TextStyles.body75(),
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      element.quantity.toString(),
                      style: TextStyles.body6(),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      element.product!.salePrice.toString(),
                      style: TextStyles.body6(),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      element.discount.toString(),
                      style: TextStyles.body6(),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 8.0, right: 15),
                    child: Text(
                      '\u{20B9}${element.getDiscountedAmount()}',
                      textAlign: TextAlign.end,
                      style: TextStyles.body6(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    return billParticulars;
  }
}

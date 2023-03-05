import 'package:intl/intl.dart';
import 'package:inventory/models/bill.dart';
import 'package:inventory/models/bill_product.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Document> getPrintableBillView(Bill bill) async {
  Document doc = Document();
  doc.addPage(Page(
    margin: const EdgeInsets.all(10),
    pageFormat: PdfPageFormat.a4,
    build: (context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: PdfColors.black),
            borderRadius: BorderRadius.circular(10),
            color: PdfColors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(
                  'Ashapura Medical and General Store',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.black),
                ),
                Text(
                  'Opposite Namdev Kirana Store, Indra Colony, Phalodi',
                  style: TextStyle(
                      fontSize: 7.5,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.black),
                ),
              ],
            ),
            SizedBox(
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
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black),
                    ),
                    Text(
                      'Customer Phone: ${bill.customerPhone}',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bill No: ${bill.billNo}',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black),
                    ),
                    Text(
                      'Bill Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(bill.date))}',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.black),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Table(
              border: TableBorder.all(width: 1.0, color: PdfColors.black),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Particulars',
                          style: TextStyle(
                              fontSize: 7.5,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Qty',
                          style: TextStyle(
                              fontSize: 7.5,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'MRP',
                            style: TextStyle(
                                fontSize: 7.5,
                                fontWeight: FontWeight.bold,
                                color: PdfColors.black),
                          )),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Discount',
                          style: TextStyle(
                              fontSize: 7.5,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, left: 4.0, bottom: 4.0, right: 7.5),
                        child: Text(
                          'Amount',
                          style: TextStyle(
                              fontSize: 7.5,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                ...getBillParticulars(bill),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Table(
              border: TableBorder.all(width: 1.0, color: PdfColors.black),
              columnWidths: const {
                0: FractionColumnWidth(0.8),
                1: FractionColumnWidth(0.2),
              },
              children: [
                TableRow(children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Total',
                            style: TextStyle(
                                fontSize: 7.5,
                                fontWeight: FontWeight.bold,
                                color: PdfColors.black)),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0, bottom: 4.0, left: 4.0, right: 7.5),
                      child: Text(bill.getDiscountedAmount().toString(),
                          style: TextStyle(
                              fontSize: 7.5,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black)),
                    ),
                  )
                ])
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text(
                  'Authorized Signatory',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.black),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    },
  ));
  return doc;
}

List<TableRow> getBillParticulars(Bill bill) {
  List<TableRow> billParticulars = [];
  for (BillProduct element in bill.billProducts) {
    if (element.product != null) {
      billParticulars.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                element.product!.name,
                style: TextStyle(
                    fontSize: 7.5,
                    fontWeight: FontWeight.bold,
                    color: PdfColors.black),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  element.quantity.toString(),
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.black),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  element.product!.salePrice.toString(),
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.black),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  element.discount.toString(),
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.black),
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4.0, left: 4.0, right: 7.5),
                  child: Text(
                    element.getDiscountedAmount(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                )),
          ],
        ),
      );
    }
  }
  return billParticulars;
}

import 'package:flutter/material.dart';
import 'package:inventory/models/bill.dart';
import 'package:inventory/screens/bill_view.dart';
import 'package:inventory/ui/text_styles.dart';

class PrintBillScreen extends StatefulWidget {
  const PrintBillScreen({super.key, required this.bill});

  final Bill bill;

  @override
  State<PrintBillScreen> createState() => _PrintBillScreenState();
}

class _PrintBillScreenState extends State<PrintBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Print Bill #${widget.bill.billNo}'),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          child: Column(children: [
            BillView(bill: widget.bill),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20)),
                onPressed: () async {},
                child: Text(
                  'Print',
                  style: TextStyles.body6().copyWith(color: Colors.white),
                ))
          ]),
        ),
      ),
    );
  }
}

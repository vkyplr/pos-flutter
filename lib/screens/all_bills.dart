import 'package:flutter/material.dart';
import 'package:inventory/models/bill.dart';
import 'package:inventory/screens/print_bill.dart';
import 'package:inventory/ui/app_colors.dart';
import 'package:inventory/ui/text_styles.dart';
import 'package:inventory/util/session_manager.dart';
import 'package:sizer/sizer.dart';

class AllBillsScreen extends StatefulWidget {
  const AllBillsScreen({super.key});

  @override
  State<AllBillsScreen> createState() => _AllBillsScreenState();
}

class _AllBillsScreenState extends State<AllBillsScreen> {
  List<Bill> bills = [];

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  void getLocalData() async {
    List<dynamic> localData = await SessionManager.getBills();
    bills = [];
    for (var element in localData) {
      bills.add(Bill.fromJson(element));
    }
    bills = bills.reversed.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All bills'),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    Expanded(child: Text('#${bills[index].billNo.toString()}')),
                    Expanded(
                        child: Center(child: Text(bills[index].customername))),
                    Expanded(
                        child: Center(child: Text(bills[index].customerPhone))),
                    Expanded(
                      child: Center(
                        child: Text(
                            '\u{20B9}${bills[index].getDiscountedAmount()}'),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PrintBillScreen(bill: bills[index])));
                                },
                                child: const Text('View Bill')),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  onDelete(index);
                                },
                                child: const Text('Delete Bill'))
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              },
              itemCount: bills.length,
            ),
          ),
        ));
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
                  'Are you sure, you want to delete this Bill?',
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
                          List<Bill> newBills = [...bills];

                          List<Map<String, dynamic>> newBillsJson = [];
                          newBills.asMap().forEach((idx, element) {
                            if (index != idx) {
                              newBillsJson.add(element.toJson());
                            }
                          });
                          SessionManager.setBills(newBillsJson).then((v) {
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
}

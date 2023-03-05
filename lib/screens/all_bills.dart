import 'package:flutter/material.dart';
import 'package:inventory/models/bill.dart';
import 'package:inventory/ui/app_colors.dart';
import 'package:inventory/util/session_manager.dart';

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
                );
              },
              itemCount: bills.length,
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:inventory/screens/add_products_screen.dart';
import 'package:inventory/screens/all_bills.dart';
import 'package:inventory/screens/new_bill.dart';
import 'package:inventory/screens/products.dart';
import 'package:inventory/ui/text_styles.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ashapura Medical and General Store'),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProductsScreen()));
              },
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
              child: Text(
                'Add Product',
                style: TextStyles.body5().copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Products()));
              },
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
              child: Text(
                'View Products',
                style: TextStyles.body5().copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const NewBill()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 32, 193, 128),
                  padding: const EdgeInsets.all(20)),
              child: Text(
                'Create Bill',
                style: TextStyles.body5().copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AllBillsScreen()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 32, 193, 128),
                  padding: const EdgeInsets.all(20)),
              child: Text(
                'View Bills',
                style: TextStyles.body5().copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

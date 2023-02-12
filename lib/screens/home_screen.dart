import 'package:flutter/material.dart';
import 'package:inventory/screens/add_products_screen.dart';
import 'package:inventory/screens/products.dart';
import 'package:inventory/ui/text_styles.dart';
import 'package:sizer/sizer.dart';

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
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProductsScreen()));
              },
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 76, 174, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Add Product',
                  style: TextStyles.body4().copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Products()));
              },
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 76, 174, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'View Products',
                  style: TextStyles.body4().copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {},
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 32, 193, 128),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'New Bill',
                  style: TextStyles.body4().copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

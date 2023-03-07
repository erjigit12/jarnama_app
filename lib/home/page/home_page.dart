// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:jarnama/app_product/app_product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyyHomePage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AppProductPage();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

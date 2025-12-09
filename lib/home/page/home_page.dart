// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jarnama/app_product/app_product.dart';
import 'package:jarnama/model/product_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> readTodos() {
    return db.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jarnama'),
      ),
      body: StreamBuilder(
        stream: readTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final List<Product> todos = snapshot.data!.docs
                .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final products = todos[index];

                return Card(
                  color: const Color.fromARGB(255, 167, 164, 164),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      products.images != null
                          ? SizedBox(
                              height: 200,
                              child: PageView.builder(
                                itemCount: products.images!.length,
                                itemBuilder: (context, index) {
                                  final images = products.images![index];
                                  return Image.network(images);
                                },
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      ListTile(
                        title: Text(
                          products.userName,
                          style: const TextStyle(fontSize: 20),
                        ),
                        leading: Text(
                          products.title,
                          style: const TextStyle(fontSize: 24),
                        ),
                        subtitle: Text(
                          products.description,
                          style: const TextStyle(fontSize: 18),
                        ),
                        trailing: Text(
                          products.price ?? '',
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Text('Error');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AppProductPage();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

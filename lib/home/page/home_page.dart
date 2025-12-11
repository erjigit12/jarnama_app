// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jarnama/add_product/add_product.dart';
import 'package:jarnama/auth/bloc/auth_bloc.dart';
import 'package:jarnama/model/product_model.dart';
import 'package:jarnama/home/page/product_detail_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final FirebaseFirestore _db;

  @override
  void initState() {
    super.initState();
    _db = context.read<FirebaseFirestore>();
  }

  Stream<QuerySnapshot> readTodos() {
    return _db.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jarnama'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOutRequested());
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Выйти',
          ),
        ],
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
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final products = todos[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: products),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (products.images != null && products.images!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: PageView.builder(
                                  itemCount: products.images!.length,
                                  itemBuilder: (context, index) {
                                    final images = products.images![index];
                                    return Image.network(
                                      images,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    );
                                  },
                                ),
                              ),
                            ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products.title,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      products.userName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                products.price != null && products.price!.isNotEmpty
                                    ? '${products.price} сом'
                                    : '',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            products.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
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
              return AppProductPage();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

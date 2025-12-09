import 'package:flutter/material.dart';
import 'package:jarnama/model/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (product.images != null && product.images!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: PageView.builder(
                  itemCount: product.images!.length,
                  itemBuilder: (context, index) {
                    final image = product.images![index];
                    return Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  product.userName,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
              if (product.price != null && product.price!.isNotEmpty)
                Text(
                  product.price!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          _InfoRow(label: 'Дата', value: product.dateTime),
          if (product.address.isNotEmpty)
            _InfoRow(label: 'Адрес', value: product.address),
          if (product.phoneNumber.isNotEmpty)
            _InfoRow(label: 'Телефон', value: product.phoneNumber),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

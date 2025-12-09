// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jarnama/components/custom_text_field.dart';
import 'package:jarnama/components/image_container.dart';
import 'package:jarnama/model/product_model.dart';
import 'package:jarnama/services/date_time_service.dart';
import 'package:jarnama/services/image_storage_service.dart';
import 'package:jarnama/services/loading_servce.dart';
import 'package:jarnama/services/store_service.dart';

class AppProductPage extends StatefulWidget {
  const AppProductPage({super.key});

  @override
  State<AppProductPage> createState() => _AppProductPageState();
}

class _AppProductPageState extends State<AppProductPage> {
  final title = TextEditingController();

  final desc = TextEditingController();

  final dateTime = TextEditingController();

  final phoneNumber = TextEditingController();

  final userName = TextEditingController();

  final address = TextEditingController();

  final price = TextEditingController();

  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppProductPage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            CustomTextField(
              controller: title,
              hintText: 'Title',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: desc,
              hintText: 'Description',
            ),
            const SizedBox(height: 20),
            ImageContainer(
              onPicked: (value) => images = value,
              onDelete: (xfile) {
                images.remove(xfile);
              },
              images: images,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: dateTime,
              hintText: 'Datetime',
              focusNode: FocusNode(),
              onTap: () async {
                await DateTimeService.showDateTime(context, (value) {
                  dateTime.text = DateFormat("d MMM, y").format(value);
                });
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: phoneNumber,
              hintText: 'PhoneNumber',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: userName,
              hintText: 'UserName',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: address,
              hintText: 'Address',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: price,
              hintText: 'Price',
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () async {
                LoadingService().showLoading(context);
                final urls = await ImageStorage().uploadImage(images);

                final product = Product(
                  title: title.text,
                  description: desc.text,
                  dateTime: dateTime.text,
                  phoneNumber: phoneNumber.text,
                  userName: userName.text,
                  address: address.text,
                  images: urls,
                  price: price.text,
                );
                await StoreService().addFirestore(product);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}

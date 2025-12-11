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
        title: const Text('Добавить продукт'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            CustomTextField(
              key: const Key('add_title'),
              controller: title,
              hintText: 'Что вы публикуете?',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              key: const Key('add_description'),
              controller: desc,
              hintText: 'Описание',
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
              key: const Key('add_date_time'),
              controller: dateTime,
              hintText: 'Дата и время',
              focusNode: FocusNode(),
              onTap: () async {
                await DateTimeService.showDateTime(context, (value) {
                  dateTime.text = DateFormat("d MMM, y").format(value);
                });
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              key: const Key('add_phone_number'),
              controller: phoneNumber,
              hintText: 'Номер телефона',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              key: const Key('add_user_name'),
              controller: userName,
              hintText: 'Имя пользователя',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              key: const Key('add_address'),
              controller: address,
              hintText: 'Адрес',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              key: const Key('add_price'),
              suffixIcon: const Icon(Icons.money),
              controller: price,
              hintText: 'Цена в сомах',
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              key: const Key('publish_button'),
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
              label: const Text('Опубликовать'),
            ),
          ],
        ),
      ),
    );
  }
}

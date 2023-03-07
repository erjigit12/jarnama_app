import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jarnama/components/custom_text_field.dart';
import 'package:jarnama/components/image_container.dart';
import 'package:jarnama/services/date_time_service.dart';

class AppProductPage extends StatelessWidget {
  AppProductPage({Key? key}) : super(key: key);

  final title = TextEditingController();
  final desc = TextEditingController();
  final dateTime = TextEditingController();
  final phoneNumber = TextEditingController();
  final userName = TextEditingController();
  final address = TextEditingController();
  final price = TextEditingController();
  final List<XFile> images = [];

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
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}

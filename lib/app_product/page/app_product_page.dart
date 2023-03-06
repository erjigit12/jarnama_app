import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarnama/components/custom_text_field.dart';

class AppProductPage extends StatelessWidget {
  const AppProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final desc = TextEditingController();
    final dateTime = TextEditingController();
    final phoneNumber = TextEditingController();
    final userName = TextEditingController();
    final address = TextEditingController();
    final price = TextEditingController();

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
            CustomTextField(
              controller: dateTime,
              hintText: 'Datetime',
              focusNode: FocusNode(),
              onTap: () async {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                        height: MediaQuery.of(context).copyWith().size.height *
                            0.25,
                        color: Colors.white,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (value) {
                            dateTime.text = value.toString();
                          },
                          initialDateTime: DateTime.now(),
                          minimumYear: 2000,
                          maximumYear: 3000,
                        ),
                      );
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.maxLines,
    this.controller,
    this.focusNode,
  });

  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final int? maxLines;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      maxLines: maxLines,
      focusNode: focusNode,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        label: Text(hintText ?? ''),
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eshop/utils/utils.dart';

class CustomTextWidget extends StatelessWidget {
  final bool isObsecure;
  final TextEditingController controller;
  final String Function(String) validator;
  final String title;
  final TextInputType keyboardType;
  const CustomTextWidget({
    Key key,
    this.title,
    this.isObsecure = false,
    this.keyboardType,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: TextFormField(
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isObsecure,
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide.none,
            ),
            hintStyle: const TextStyle(color: Colors.black54),
            filled: true,
            fillColor: kWhiteColor,
            hintText: title),
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}

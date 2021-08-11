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
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: Colors.white),
      width: 350.w,
      // height: 60.h,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      // padding: const EdgeInsets.fromLTRB(10, 15, 10, 12),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
          keyboardType: keyboardType,
          obscureText: isObsecure,
          style: const TextStyle(fontSize: 15.0, color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            border: InputBorder.none,
            fillColor: Colors.white,
            hintText: title,
            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 12.0),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
          ),
          controller: controller,
          validator: validator
        ),
      ),
    );
  }
}

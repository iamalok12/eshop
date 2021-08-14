import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomMobileTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomMobileTextField({
    Key key,
    this.controller,
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
      height: 60.h,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 12),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 15.0, color: Colors.black),
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              filled: true,
              border: InputBorder.none,
              fillColor: Colors.white,
              hintText: "Mobile Number",
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
            validator: (text) {
              if (isNumeric(text) && text.length == 10) {
                return null;
              } else {
                print("wrong");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invalid mobile number"),
                  ),
                );
                return "";
              }
            }),
      ),
    );
  }
}

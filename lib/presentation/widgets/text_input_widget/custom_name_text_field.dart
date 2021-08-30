import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomNameTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomNameTextField({
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
      width: 296.w,
      height: 48.h,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 12),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
            keyboardType: TextInputType.name,
            style: const TextStyle(fontSize: 15.0, color: Colors.black),
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              filled: true,
              border: InputBorder.none,
              fillColor: Colors.white,
              hintText: "Name",
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
              if (isAlpha(text) && text.length >= 3) {
                return null;
              } else {
                Fluttertoast.showToast(
                    msg: "Name must contain minimum 3 characters",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                return "";
              }
            }),
      ),
    );
  }
}

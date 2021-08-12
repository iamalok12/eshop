import 'package:flutter/material.dart';
import 'package:eshop/utils/utils.dart';

class CustomAddressTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomAddressTextField({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0.w),
          ),
          color: Colors.white),
      width: 350.w,
      height: 60.h,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 12),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextFormField(
            keyboardType: TextInputType.streetAddress,
            style: TextStyle(fontSize: 15.0.sp, color: Colors.black),
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              filled: true,
              border: InputBorder.none,
              fillColor: kWhiteColor,
              hintText: "Address",
              contentPadding: EdgeInsets.only(left: 14.0.w, bottom: 12.0.w),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kWhiteColor),
                borderRadius: BorderRadius.circular(25.7.w),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7.w),
              ),
            ),
            controller: controller,
            validator: (text){
              if(isAlpha(text)&&text.length>=3){
                return null;
              }
              else{
                Fluttertoast.showToast(
                    msg: "Address is too short",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0.sp
                );
                return "";
              }
            }
        ),
      ),
    );
  }
}

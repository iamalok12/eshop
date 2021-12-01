import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum PrimaryTextFieldOptions{
  name,
  mobile,
  pinCode,
  address,
  price
}

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final PrimaryTextFieldOptions textFieldOptions;

  const PrimaryTextField({Key key,@required this.controller,@required this.label,@required this.keyboardType,@required this.textFieldOptions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
      width: 260.w,
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType:keyboardType,
        validator: (value){
          if(textFieldOptions==PrimaryTextFieldOptions.name){
            if(value.length<4){
              return "Input is too short";
            }
            else{
              return null;
            }
          }
          else if(textFieldOptions==PrimaryTextFieldOptions.mobile){
            if(value.length!=10){
              return "Invalid number";
            }
            else{
              return null;
            }
          }
          else if(textFieldOptions==PrimaryTextFieldOptions.pinCode){
            if(value.length!=6){
              return "Invalid pin code";
            }
            else{
              return null;
            }
          }
          else if(textFieldOptions==PrimaryTextFieldOptions.price){
            if(isNumericUsingTryParse(value)==false){
              return "Invalid amount";
            }
            else{
              return null;
            }
          }
          else{
            if(value.length<4){
              return "Input is too short";
            }
            else{
              return null;
            }
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
        ),
      ),
    );
  }
  bool isNumericUsingTryParse(String string) {
    if (string == null || string.isEmpty||string=='0') {
      return false;
    }
    final number = num.tryParse(string);
    if (number == null) {
      return false;
    }
    return true;
  }
}

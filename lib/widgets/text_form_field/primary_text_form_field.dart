import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum PrimaryTextFieldOptions{
  name,
  mobile,
  pinCode,
  address
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
      padding: const EdgeInsets.all(2),
      width: 260.w,
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        controller: controller,
        keyboardType:keyboardType,
        validator: (value){
          if(textFieldOptions==PrimaryTextFieldOptions.name){
            if(value.length<4){
              return "Name is too short";
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
          else{
            if(value.length<4){
              return "Address is too short";
            }
            else{
              return null;
            }
          }
        },
        decoration: InputDecoration(

          border: InputBorder.none,
          hintText: "  $label"
        ),
      ),
    );
  }
}

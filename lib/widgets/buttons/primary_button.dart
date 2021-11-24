import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  const PrimaryButton({Key key, this.callback, this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff0066CC),
          borderRadius: BorderRadius.circular(6),
        ),
        height: 35.h,
        width: 120.w,
        child: Center(child: Text(label,style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.bold),),),
      ),
    );
  }
}

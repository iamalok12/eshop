import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  const SecondaryButton({Key key, this.callback, this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
        ),
        height: 35.h,
        width: 120.w,
        child: Center(child: Text(label,style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.bold),),),
      ),
    );
  }
}

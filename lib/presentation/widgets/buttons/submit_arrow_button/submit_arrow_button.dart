import 'package:flutter/material.dart';
import 'package:eshop/utils/utils.dart';

class SubmitArrowButton extends StatelessWidget {
  final VoidCallback callback;
  const SubmitArrowButton({Key key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:callback,
      child: Container(
        height: 58.h,
        width: 56.w,
        decoration: BoxDecoration(
          color: kButtonColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_forward_sharp,
          color: kWhiteColor,
          size: 24,
        ),
      ),
    );
  }
}

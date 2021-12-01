import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WarningWidget extends StatelessWidget {
  final String msg;
  final VoidCallback callback;

  const WarningWidget({Key key, this.msg, this.callback}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 230.h,
        width: 300.w,
        color: kWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                msg,
                style: TextStyle(fontSize: 20.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 150.w,
              width: 150.w,
              child: Lottie.asset("assets/images/warning.json",
                  fit: BoxFit.fill,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SecondaryButton(
                  label: "Cancel",
                  callback: (){
                    Navigator.pop(context);
                  },
                ),
                PrimaryButton(
                  label: "Confirm",
                  callback: callback,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eshop/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200.h,
              width: 200.w,
              color: Colors.amber,
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return CustomDialogue(callback: (){
                        Navigator.pop(context);
                      }, text: "Transaction Done", type: dialogueType.error);
                    },
                  );
                },
                child: const Text("Hit me"))
          ],
        ),
      ),
    );
  }
}

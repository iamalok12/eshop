import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Column(
          children: [
            const Text("Loading..."),
            SizedBox(
              height: 30.h,
            ),
            const LinearProgressIndicator(
              backgroundColor: Colors.amber,
            ),
          ],
        )
      ],
    );
  }
}

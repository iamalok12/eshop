import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


enum dialogueType {
  error,
  ok,
}

class CustomDialogue extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final dialogueType type;
  const CustomDialogue(
      {@required this.callback, @required this.text, @required this.type});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Center(
          child: Column(
            children: [
              Text(text),
              SizedBox(
                height: 80.h,
                width: 80.h,

              ),
              ElevatedButton(
                onPressed: callback,
                child: const Text("OK"),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

enum dialogueType{
  error,
  ok,
}

class CustomDialogue extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final dialogueType type;
  const CustomDialogue({@required this.callback,@required this.text,@required this.type});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Center(
          child: Column(
            children: [
              Text(text),
              Icon(type==dialogueType.error?Icons.clear:Icons.airline_seat_individual_suite_outlined),
              ElevatedButton(onPressed: callback,)
            ],
          ),
        )
      ],
    );
  }
}

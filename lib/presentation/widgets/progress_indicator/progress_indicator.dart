import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Loading..."),
              const SizedBox(width: 30,),
              SizedBox(child: Lottie.asset('assets/images/loading.json',height: 80,width: 80)),
            ],
          ),
        )
      ],
    );
  }
}

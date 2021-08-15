import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200.h,
              ),
              Text(
                "E-Shop",
                style: GoogleFonts.orbitron(
                  fontSize: 50.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

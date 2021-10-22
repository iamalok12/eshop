import 'package:eshop/models/models.dart';
import 'package:eshop/screens/authentication/login_screen.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';

class CustomerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SecondaryButton(
                label: "Sign out",
                callback: () async {
                  MasterModel.signOut().then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(),),);
                  });
                },
              ),
              const Text("Customer home"),
            ],
          ),
        ),
      ),
    );
  }
}

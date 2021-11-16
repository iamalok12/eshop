import 'package:eshop/models/models.dart';
import 'package:eshop/screens/authentication/login_screen.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';

class CustomerProfile extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: SafeArea(
        child: Column(
          children: [
            SecondaryButton(
              label: "Sign out",
              callback: () async {
                LoadingWidget.showLoading(context);
                MasterModel.signOut().then((value) {
                  Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),),);
                }).onError((error, stackTrace){
                  ErrorHandle.showError("Something wrong");
                  LoadingWidget.removeLoading(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

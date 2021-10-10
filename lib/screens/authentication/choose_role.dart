import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/authentication/customer_register.dart';
import 'package:eshop/screens/authentication/seller_register1.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class ChooseRole extends StatefulWidget {
  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  Future<void> chooseRole(String type) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(MasterModel.auth.currentUser.email)
        .set({
      "type": type,
      "completionStatus":0
    }).then((value) {
          if(type=="seller"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerRegister1(),),);
          }
          else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerRegister(),),);
          }
    }).onError((error, stackTrace){
      //todo show error box
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                chooseRole("customer");
              },
              child: const Text("Customer"),
            ),
            ElevatedButton(
              onPressed: () {
                chooseRole("seller");
              },
              child: const Text("Seller"),
            ),
          ],
        ),
      ),
    );
  }
}

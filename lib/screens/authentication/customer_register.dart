import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/customer/customer_home/customer_home.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomerRegister extends StatelessWidget {
  final _customerName=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _customerName,
            ),
            ElevatedButton(
              onPressed: (){
                Future<void> registerCustomer()async{
                  await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
                    "name":_customerName.text.trim(),
                    "completionStatus":1
                  }).then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerHome(),),);
                  }).onError((error, stackTrace){
                    Fluttertoast.showToast(
                        msg: "Something wrong",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white54,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );
                  });
                }
                registerCustomer();
              },
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}

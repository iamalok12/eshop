import 'package:eshop/models/models.dart';
import 'package:eshop/screens/customer/customer_home/customer_home.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomerRegister extends StatelessWidget {
  final _customerName = TextEditingController();
  final _customerMobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    "Sign up",
                    style: kPageHeading,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  PrimaryTextField(
                      controller: _customerName,
                      label: "Name",
                      keyboardType: TextInputType.name,
                      textFieldOptions: PrimaryTextFieldOptions.name,),
                  SizedBox(
                    height: 25.h,
                  ),
                  PrimaryTextField(
                      controller: _customerMobile,
                      label: "Mobile",
                      keyboardType: TextInputType.number,
                      textFieldOptions: PrimaryTextFieldOptions.mobile,),
                  SizedBox(
                    height: 260.h,
                  ),
                  PrimaryButton(
                    label: "Submit",
                    callback: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          LoadingWidget.showLoading(context);
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(MasterModel.auth.currentUser.email)
                              .set({
                            "name": _customerName.text.trim(),
                            "mobile": _customerMobile.text.trim(),
                            "type": "customer"
                          }).then((value) {
                            LoadingWidget.removeLoading(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerHome(),
                              ),
                            );
                          });
                        } catch (e) {
                          ErrorHandle.showError("Something wrong");
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

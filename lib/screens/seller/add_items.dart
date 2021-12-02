import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/textstyles.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80.h,
                ),
                Text(
                  "Add item",
                  style: kPageHeading,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryTextField(
                  controller: _productName,
                  label: "Product name",
                  keyboardType: TextInputType.name,
                  textFieldOptions: PrimaryTextFieldOptions.address,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryTextField(
                  controller: _productPrice,
                  label: "Product price",
                  keyboardType: TextInputType.number,
                  textFieldOptions: PrimaryTextFieldOptions.price,
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryTextField(
                  controller: _productDescription,
                  label: "Description",
                  keyboardType: TextInputType.name,
                  textFieldOptions: PrimaryTextFieldOptions.address,
                ),
                SizedBox(
                  height: 180.h,
                ),
                PrimaryButton(
                  label: "Next",
                  callback: () async {
                    if (_formKey.currentState.validate()) {
                      pushNewScreen(
                        context,
                        screen: AddItems2(productName: _productName.text.trim(),productPrice:double.parse(_productPrice.text.trim()),productDescription: _productDescription.text.trim(),),
                        withNavBar: false,
                      );
                    } else {
                      ErrorHandle.showError("Please fill properly");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

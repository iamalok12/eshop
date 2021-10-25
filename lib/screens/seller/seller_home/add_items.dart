
import 'package:eshop/models/master_model.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/utils/textstyles.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/alert/progress_indicator.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:eshop/widgets/text_form_field/primary_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'add_items2.dart';


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
                      showDialog(context: context, builder:(_){
                        return LoadingIndicator();
                      },);
                      final String docID =
                      DateTime.now().microsecondsSinceEpoch.toString();
                      await FirebaseFirestore.instance
                          .collection("Items")
                          .doc(docID)
                          .set({
                        "productName": _productName.text.trim(),
                        "productPrice": _productPrice.text.trim(),
                        "productDescription": _productDescription.text.trim(),
                        "seller": MasterModel.auth.currentUser.email,
                      }).then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return AddItem();
                            },
                          ),
                              (_) => false,
                        );
                        pushNewScreen(
                          context,
                          screen: AddItems2(docID: docID),
                          withNavBar: false,
                        );
                      }).onError((error, stackTrace) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return AddItem();
                            },
                          ),
                              (_) => false,
                        );
                        ErrorHandle.showError("Something wrong");
                      });
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

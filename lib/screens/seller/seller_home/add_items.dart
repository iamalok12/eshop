import 'package:eshop/models/loading.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/utils/textstyles.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:eshop/widgets/text_form_field/primary_text_form_field.dart';
import 'package:flutter/material.dart';
import 'add_items2.dart';

class AddItems extends StatelessWidget {
  final _productName = TextEditingController();
  final _productPrice = TextEditingController();
  final _productDescription = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
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
                textFieldOptions: PrimaryTextFieldOptions.address,),
            SizedBox(
              height: 20.h,
            ),
            PrimaryTextField(
                controller: _productPrice,
                label: "Product price",
                keyboardType: TextInputType.number,
                textFieldOptions: PrimaryTextFieldOptions.price,),
            SizedBox(
              height: 20.h,
            ),
            PrimaryTextField(
                controller: _productDescription,
                label: "Description",
                keyboardType: TextInputType.name,
                textFieldOptions: PrimaryTextFieldOptions.address,),
            SizedBox(
              height: 180.h,
            ),
            PrimaryButton(
              label: "Next",
              callback: () async{
                if(_formKey.currentState.validate()){
                  LoadingWidget.showLoading(context);
                  final String docID=DateTime.now().microsecondsSinceEpoch.toString();
                  await FirebaseFirestore.instance.collection("Items").doc(docID).set({
                    "productName":_productName.text.trim(),
                    "productPrice":_productPrice.text.trim(),
                    "productDescription":_productDescription.text.trim(),
                    "seller":MasterModel.auth.currentUser.email,
                  }).then((value){
                    LoadingWidget.removeLoading(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItems2(docID: docID,),),);
                  }).onError((error, stackTrace){
                    LoadingWidget.removeLoading(context);
                    ErrorHandle.showError("Something wrong");
                  });
                }
                else{
                  ErrorHandle.showError("Please fill properly");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

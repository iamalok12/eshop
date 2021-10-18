import 'dart:io';

import 'package:eshop/widgets/alert/progress_indicator.dart';
import 'package:eshop/widgets/buttons/payment_button.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:eshop/widgets/image_upload/image_upload.dart';
import 'package:eshop/widgets/text_form_field/primary_text_form_field.dart';
import 'package:flutter/material.dart';

import 'models/image_upload_and_crop.dart';

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _formKey = GlobalKey<FormState>();

  final texTer = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                PaymentBox(month: "gaged",amount: 77,callback: (){},)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

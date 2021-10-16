import 'package:eshop/widgets/alert/progress_indicator.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:eshop/widgets/text_form_field/primary_text_form_field.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _formKey = GlobalKey<FormState>();

  final texter = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              PrimaryTextField(
                controller: texter,
                label: "Zip code",
                keyboardType: TextInputType.number,
                textFieldOptions: PrimaryTextFieldOptions.mobile,
              ),
              PrimaryButton(
                label: "Submit",
                callback: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return LoadingIndicator();
                      });
                },
              ),
              const SecondaryButton(
                label: "cancel",
              ),
              DropdownButton<String>(
                hint: Text("asas"),
                underline: Text(""),
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              )
            ],
          ),
        )),
      ),
    );
  }
}

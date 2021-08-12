import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/text_widget/custom_mobile_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(36.0),
                    ),
                    image: DecorationImage(
                        image: AssetImage("assets/images/otp_logo.jpeg"),
                        fit: BoxFit.fill),
                  ),
                  height: 235.h,
                  width: 299.w,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 26, left: 30, right: 20, bottom: 20),
                    child: RichText(
                      text: TextSpan(
                        text: "Get ",
                        style: kViewStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text: " Started",
                            style: kViewStyle.copyWith(color: kBlueColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomMobileTextField(
                controller: _phoneController,
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    print("working");
                  }
                },
                child: Container(
                  height: 58.h,
                  width: 56.w,
                  decoration: BoxDecoration(
                    color: kButtonColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_sharp,
                    color: kWhiteColor,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

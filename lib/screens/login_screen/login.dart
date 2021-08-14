import 'package:eshop/logics/login/login_bloc.dart';
import 'package:eshop/logics/login/login_state.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/buttons/submit_arrow_button/submit_arrow_button.dart';
import 'package:eshop/widgets/text_input_widget/custom_mobile_text_field.dart';
import 'package:eshop/widgets/text_input_widget/custom_otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is InitialLoginState) {
                  return PhoneInput();
                } else if (state is OtpSentState) {
                  return OtpInput();
                } else if (state is LoadingState) {
                  return Text("asasas");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneInput extends StatelessWidget {
  final _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomMobileTextField(
            controller: _phoneController,
          ),
          SizedBox(
            height: 20.h,
          ),
          SubmitArrowButton(
            callback: (){
              BlocProvider.of<LoginBloc>(context).add(SendOtpEvent(_phoneController.value.text));
            },
          )
        ],
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  final _otp = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomOtpTextField(
            controller: _otp,
          ),
          SizedBox(
            height: 20.h,
          ),
          const SubmitArrowButton()
        ],
      ),
    );
  }
}

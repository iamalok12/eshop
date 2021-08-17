import 'package:eshop/data/terms_condition/term_condition.dart';
import 'package:eshop/logics/login/login_bloc.dart';
import 'package:eshop/presentation/screens/choose_role/choose_role.dart';
import 'package:eshop/presentation/screens/customer_home/customer_home.dart';
import 'package:eshop/presentation/screens/seller_home/seller_home.dart';
import 'package:eshop/presentation/widgets/widgets.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:eshop/logics/logics.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/otp_login.png"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
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
                      image: AssetImage("assets/images/otp_screen_top.gif"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  height: 219.h,
                  width: 244.w,
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
                        style: kViewStyle.copyWith(color: Color(0xfff9f9f9)),
                        children: <TextSpan>[
                          TextSpan(
                            text: " Started",
                            style: kViewStyle.copyWith(color: Colors.black),
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
              BlocConsumer<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is InitialLoginState ||
                      state is ExceptionState ||
                      state is AnotherNumberState) {
                    return PhoneInput();
                  } else {
                    return OtpInput();
                  }
                },
                listener: (context, state) {
                  if (state is LoadingState) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return CustomProgressIndicator();
                      },
                    );
                  } else if (state is OtpExceptionState) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid Otp"),
                      ),
                    );
                  } else if (state is ExceptionState) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Maximum attempt exceeded please try again after sometime",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (state is LoginCompleteState) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChooseRole()));
                  } else if (state is CustomerAuth) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerHome()));
                  } else if (state is SellerAuth) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SellerHome()));
                  } else if (state is AnotherNumberState) {
                    return;
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneInput extends StatelessWidget {
  final _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TermAndCondition _termAndCondition = TermAndCondition();

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
            height: 10.h,
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Card(
                        color: Colors.black87,
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Text(
                            _termAndCondition.message,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Card(
              color: Colors.black12,
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: const Text(
                  "I agree with the terms of services and privacy policy",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SubmitArrowButton(
            callback: () {
              if (_formKey.currentState.validate()) {
                BlocProvider.of<LoginBloc>(context).add(
                  SendOtpEvent(
                    phoNo: "+91${_phoneController.text}",
                  ),
                );
              }
            },
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(TryAnotherNumber());
                },
                child: const Text("Try another number"),
              ),
              SizedBox(
                width: 20.w,
              ),
              TextButton(
                onPressed: () {

                  BlocProvider.of<LoginBloc>(context).add(
                    OtpResendEvent()
                  );
                },
                child: const Text("Resend"),
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          SubmitArrowButton(
            callback: () {
              BlocProvider.of<LoginBloc>(context).add(
                VerifyOtpEvent(otp: "+91$_otp.text"),
              );
            },
          ),
        ],
      ),
    );
  }
}

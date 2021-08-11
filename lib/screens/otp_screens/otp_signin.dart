import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/text_widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class OtpLogin extends StatefulWidget {

  @override
  _OtpLoginState createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: sized_box_for_whitespace
            const SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(36.0)),
                  image: DecorationImage(
                      image: AssetImage("images/otp_logo.jpeg"),
                      fit: BoxFit.fill
                  ),
                ),
                height: 300,
                width: 350,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 26,left: 30,right: 20,bottom: 20),
                  child: RichText(
                    text: const TextSpan(
                        text: "Get ",
                        style: kViewStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text: " Started",
                            style: kViewStyle
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            const CustomTextWidget(title: "Mobile Number"),

          ],
        ),
      ),
    );
  }
}

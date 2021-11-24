import 'package:eshop/models/models.dart';
import 'package:eshop/screens/customer/customer_root.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> goToScreen() async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("users")
          .doc(MasterModel.auth.currentUser.email)
          .get();
      if (data.exists) {
        final String type = data.data()['type'] as String;
        if (type == 'customer') {
          await Future.delayed(const Duration(milliseconds: 100));
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerRoot(),
            ),
          );
        } else if (type == 'seller') {
          await Future.delayed(const Duration(milliseconds: 100));
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SellerRoot(),
            ),
          );
        }
      } else {
        await MasterModel.signOut();
        await Future.delayed(const Duration(milliseconds: 100));
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBlack,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: DefaultTextStyle(
            style: kIntroStyle,
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 10),
              totalRepeatCount: 1,
              onFinished: goToScreen,
              animatedTexts: [
                RotateAnimatedText(
                  'E-Shop',
                  textStyle: kIntoAnimation,
                  rotateOut: false,
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

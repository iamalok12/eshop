import 'package:eshop/models/models.dart';
import 'package:eshop/screens/authentication/seller_register1.dart';
import 'package:eshop/screens/authentication/seller_register2.dart';
import 'package:eshop/screens/authentication/seller_register3.dart';
import 'package:eshop/test_screen.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.black),
          // backgroundColor: Colors.lightBlueAccent,
        ),
        home: SellerRegister3(),
      ),
    );
  }
}

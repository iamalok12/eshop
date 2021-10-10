import 'package:eshop/screens/authentication/seller_register1.dart';
import 'package:eshop/screens/splash_screen/splash_screen.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:eshop/models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocDelegate();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => MaterialApp(
        theme: ThemeData(
          backgroundColor: kBackgroundColor,
        ),
        home: SellerRegister1(),
      ),
    );
  }
}

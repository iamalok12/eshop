import 'package:eshop/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:eshop/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360,640),
      builder: ()=>MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.pink,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

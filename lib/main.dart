import 'package:eshop/models/models.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MasterModel.sharedPreferences = await SharedPreferences.getInstance();
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
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: kBlack),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

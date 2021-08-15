import 'package:eshop/presentation/screens/screens.dart';
import 'package:eshop/presentation/screens/seller_home/seller_home.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:eshop/logics/logics.dart';
import 'package:eshop/models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AuthenticationBloc()..add(AppStarted()),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginBloc(),
        )
      ],
      child: MyApp(),
    ),
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
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, state) {
            if (state is UnAuthenticated) {
              return LoginScreen();
            } else if (state is CustomerAuthenticated) {
              return CustomerHome();
            } else if (state is SellerAuthenticated) {
              return SellerHome();
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}

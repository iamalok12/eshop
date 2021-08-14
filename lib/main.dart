import 'package:eshop/logics/authentication_state/authentication_bloc.dart';
import 'package:eshop/logics/login/login_bloc.dart';
import 'package:eshop/presentation/screens/customer_home/customer_home.dart';
import 'package:eshop/presentation/screens/login_screen/login.dart';
import 'package:eshop/presentation/screens/splash_screen/splash_screen.dart';
import 'package:eshop/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logics/login/login_bloc.dart';

class MyBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }
}

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
          primarySwatch: Colors.orange,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, state) {
            if (state is UnAuthenticated) {
              return LoginScreen();
            } else if (state is CustomerAuthenticated) {
              return CustomerHome();
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}

import 'package:eshop/screens/home.dart';
import 'package:eshop/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:eshop/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logics/login/authenticate/authentication_event.dart';
import 'logics/login/authenticate/authentication_state.dart';
import 'logics/login/authenticate/authentication_bloc.dart';
import 'logics/login/data/user_repository.dart';
import 'logics/login/login/login_page.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc(userRepository)..add(AppStarted()),
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({Key key, this.userRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360,640),
      builder: ()=>MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashScreen();
            } else if (state is Unauthenticated) {
              return LoginPage(
                userRepository: userRepository,
              );
            } else if (state is Authenticated) {
              return Home();
            } else {
              return SplashScreen();
            }
            ;
          },
        ),
      ),
    );
  }
}

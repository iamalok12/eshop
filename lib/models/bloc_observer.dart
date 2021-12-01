import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    debugPrint(error.toString());
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    debugPrint(event.toString());
  }
}

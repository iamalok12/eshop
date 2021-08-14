import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eshop/data/authentication/authentication_repo.dart';
import 'package:meta/meta.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());
  final AuthRepo _repo=AuthRepo();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AppStarted){
      if(_repo.auth.currentUser==null){
        yield UnAuthenticated();
      }
      else{
        print(_repo.auth.currentUser.phoneNumber);
        final String type=await _repo.type();
        if(type=="customer"){
          yield CustomerAuthenticated();
        }
        else{
          yield SellerAuthenticated();
        }
      }
    }
  }
}

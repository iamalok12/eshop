import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AppStarted){
      if(_auth.currentUser==null){
        yield UnAuthenticated();
      }
      else{
        print(_auth.currentUser.phoneNumber);
        final data=await FirebaseFirestore.instance.collection("users").doc(_auth.currentUser.phoneNumber).get();
        final String type=data.data()['type'].toString();
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

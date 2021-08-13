import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {}

class InitialLoginState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OtpSentState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginCompleteState extends LoginState {
  final User _firebaseUser;

  LoginCompleteState(this._firebaseUser);

  User getUser(){
    return _firebaseUser;
  }
  @override
  List<Object> get props => [_firebaseUser];
}

class ExceptionState extends LoginState {
  final String message;

  ExceptionState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class OtpExceptionState extends LoginState {
  final String message;

  OtpExceptionState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

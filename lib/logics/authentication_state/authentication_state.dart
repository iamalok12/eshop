part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState{}

class SellerAuthenticated extends AuthenticationState{}

class CustomerAuthenticated extends AuthenticationState{}



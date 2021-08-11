part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}


class PostState extends Equatable{
  @override
  List<Object> get props => [];

}


class PostIsNotSearched extends PostState{

}

class PostIsLoading extends PostState{

}

class PostIsLoaded extends PostState{
  final _address;

  PostIsLoaded(this._address);

  PostModel get getWeather => _address;
  @override
  List<Object> get props => [_address];
}

class PostIsNotLoaded extends PostState{
}
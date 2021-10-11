part of 'choose_city_bloc.dart';

@immutable
abstract class ChooseCityState {}

class ChooseCityInitial extends ChooseCityState {}

class ChooseCityLoading extends ChooseCityState{}

class ChooseCityError extends ChooseCityState{}

class ChooseCityLoaded extends ChooseCityState{
  final List<String> list;
  ChooseCityLoaded(this.list);
}



part of 'get_shops_bloc.dart';

@immutable
abstract class GetShopsState {}

class GetShopsInitial extends GetShopsState {}
class GetShopsError extends GetShopsState {}
class GetShopsLoading extends GetShopsState {}
class GetShopsNoShop extends GetShopsState {}
class GetShopsFound extends GetShopsState {
  final List<FetchShopsClass> list;
  GetShopsFound(this.list);
}
class GetShopsNotSelected extends GetShopsState {}

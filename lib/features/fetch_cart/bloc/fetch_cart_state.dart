part of 'fetch_cart_bloc.dart';

@immutable
abstract class FetchCartState {}

class FetchCartInitial extends FetchCartState {}
class FetchCartLoading extends FetchCartState {}
class FetchCartError extends FetchCartState {}
class FetchCartEmpty extends FetchCartState {}
class FetchCartLoaded extends FetchCartState {
  final List<FetchCartClass> list;
  FetchCartLoaded({this.list});
}

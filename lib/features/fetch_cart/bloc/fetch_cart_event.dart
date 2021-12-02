part of 'fetch_cart_bloc.dart';

@immutable
abstract class FetchCartEvent {}

class FetchCartTriggerEvent extends FetchCartEvent{
  final String productID;
  FetchCartTriggerEvent(this.productID);
}

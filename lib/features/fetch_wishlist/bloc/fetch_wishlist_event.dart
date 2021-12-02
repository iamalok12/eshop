part of 'fetch_wishlist_bloc.dart';

@immutable
abstract class FetchWishlistEvent {}

class FetchWishListTriggerEvent extends FetchWishlistEvent{
  final String productID;
  FetchWishListTriggerEvent(this.productID);
}

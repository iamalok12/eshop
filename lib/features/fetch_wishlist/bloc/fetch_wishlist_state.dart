part of 'fetch_wishlist_bloc.dart';

@immutable
abstract class FetchWishlistState {}

class FetchWishlistInitial extends FetchWishlistState {}
class FetchWishlistLoading extends FetchWishlistState {}
class FetchWishlistError extends FetchWishlistState {}
class FetchWishlistEmpty extends FetchWishlistState {}
class FetchWishlistLoaded extends FetchWishlistState {
  final List<FetchWishListClass> list;
  FetchWishlistLoaded({this.list});
}

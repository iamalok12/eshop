part of 'fetch_order_seller_bloc.dart';

@immutable
abstract class FetchOrderSellerState {}

class FetchOrderSellerInitial extends FetchOrderSellerState {}
class FetchOrderSellerError extends FetchOrderSellerState {}
class FetchOrderSellerLoading extends FetchOrderSellerState {}
class FetchOrderSellerEmpty extends FetchOrderSellerState {}
class FetchOrderSellerLoaded extends FetchOrderSellerState {
  final List<OrderModel> list;
  FetchOrderSellerLoaded(this.list);
}

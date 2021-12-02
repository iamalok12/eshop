part of 'fetch_products_bloc.dart';

@immutable
abstract class FetchProductsState {}

class FetchProductsInitial extends FetchProductsState {}
class FetchProductsError extends FetchProductsState {}
class FetchProductsEmpty extends FetchProductsState {}
class FetchProductsLoading extends FetchProductsState {}
class FetchProductsLoaded extends FetchProductsState {
  final List<SellerItemsClass> list;
  FetchProductsLoaded(this.list);
}

part of 'fetch_products_bloc.dart';

@immutable
abstract class FetchProductsEvent {}

class FetchProductTrigger extends FetchProductsEvent{
  final String sellerMail;
  FetchProductTrigger(this.sellerMail);
}

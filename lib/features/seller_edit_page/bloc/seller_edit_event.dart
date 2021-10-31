part of 'seller_edit_bloc.dart';

@immutable
abstract class SellerEditEvent {}

class SellerEditTrigger extends SellerEditEvent{}

class SellerEditLoadMore extends SellerEditEvent{
  final int addItems;
  SellerEditLoadMore(this.addItems);
}

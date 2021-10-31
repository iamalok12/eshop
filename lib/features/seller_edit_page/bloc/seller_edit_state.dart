part of 'seller_edit_bloc.dart';

@immutable
abstract class SellerEditState {}

class SellerEditInitial extends SellerEditState {}

class SellerEditLoading extends SellerEditState{}

class SellerEditError extends SellerEditState{}

class SellerEditLoaded extends SellerEditState{

}

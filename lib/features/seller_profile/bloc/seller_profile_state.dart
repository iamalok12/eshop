part of 'seller_profile_bloc.dart';

@immutable
abstract class SellerProfileState {}

class SellerProfileInitial extends SellerProfileState {}

class SellerProfileLoading extends SellerProfileState {}

class SellerProfileError extends SellerProfileState {}

class SellerProfileLoaded extends SellerProfileState {
  final List<SellerProfileClass> list;
  SellerProfileLoaded(this.list);
}





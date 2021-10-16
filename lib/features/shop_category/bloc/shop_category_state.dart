part of 'shop_category_bloc.dart';

@immutable
abstract class ShopCategoryState {}

class ShopCategoryLoading extends ShopCategoryState {}

class ShopCategoryLoaded extends ShopCategoryState {
  final List<String> list;
  ShopCategoryLoaded(this.list);
}

class ShopCategoryError extends ShopCategoryState {}

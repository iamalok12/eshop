part of 'edit_items_bloc.dart';

@immutable
abstract class EditItemsState {}

class EditItemsInitial extends EditItemsState {}


class EditItemsError extends EditItemsState {}


class EditItemsEmpty extends EditItemsState {}


class EditItemsLoading extends EditItemsState {}


class EditItemsLoaded extends EditItemsState {
  final List<SellerItems> list;
  EditItemsLoaded(this.list);
}

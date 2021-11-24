import 'package:eshop/features/edit_items_seller/data/edit_items_repo.dart';
import 'package:eshop/models/seller_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_items_event.dart';
part 'edit_items_state.dart';

class EditItemsBloc extends Bloc<EditItemsEvent, EditItemsState> {
  EditItemsBloc() : super(EditItemsInitial());
  final EditItemsRepo _repo=EditItemsRepo();
  @override
  Stream<EditItemsState> mapEventToState(EditItemsEvent event)async*{
    if(event is EditItemsTrigger){
      yield EditItemsLoading();
      try{
        final List<SellerItems> list=await _repo.fetchItems();
        if(list.isEmpty){
          yield EditItemsEmpty();
        }
        else{
          yield EditItemsLoaded(list);
        }
      }
      catch(e){
        yield EditItemsError();
      }
    }
  }
}

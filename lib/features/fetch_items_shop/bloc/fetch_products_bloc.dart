import 'package:eshop/features/fetch_items_shop/data/fetch_shop_items.dart';
import 'package:eshop/features/fetch_items_shop/domain/seller_item_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_products_event.dart';
part 'fetch_products_state.dart';

class FetchProductsBloc extends Bloc<FetchProductsEvent, FetchProductsState> {
  FetchProductsBloc() : super(FetchProductsInitial());
  final FetchShopItems _items=FetchShopItems();
  @override
  Stream<FetchProductsState> mapEventToState(FetchProductsEvent event)async*{
    if(event is FetchProductTrigger){
      yield FetchProductsLoading();
      try{
        final List<SellerItemsClass> list=await _items.getItemsShop(event.sellerMail);
        if(list.isNotEmpty){
          yield FetchProductsLoaded(list);
        }
        else{
          yield FetchProductsEmpty();
        }
      }
      catch(e){
        yield FetchProductsError();
      }
    }
  }
}

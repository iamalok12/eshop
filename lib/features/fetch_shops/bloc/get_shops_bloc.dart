import 'dart:async';
import 'package:eshop/features/fetch_shops/data/fetch_shops.dart';
import 'package:eshop/features/fetch_shops/domain/fetch_shop_class.dart';
import 'package:eshop/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_shops_event.dart';
part 'get_shops_state.dart';

class GetShopsBloc extends Bloc<GetShopsEvent, GetShopsState> {
  GetShopsBloc() : super(GetShopsInitial());
  final FetchShops _fetchShops=FetchShops();

  @override
  Stream<GetShopsState> mapEventToState(GetShopsEvent event)async*{
    if(event is GetShopsTriggerEvent){
      yield GetShopsLoading();
      final city=MasterModel.sharedPreferences.getString("city");
      if(city==null){
        yield GetShopsNotSelected();
      }
      else{
        try{
          final List<FetchShopsClass> shopList=await _fetchShops.getShops(city);
          if(shopList.isEmpty){
            yield GetShopsNoShop();
          }
          else{
            yield GetShopsFound(shopList);
          }
        }
        catch(e){
          yield GetShopsError();
        }
      }
    }
  }
}

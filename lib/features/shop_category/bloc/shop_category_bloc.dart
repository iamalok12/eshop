import 'dart:async';

import 'package:eshop/features/shop_category/data/shop_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shop_category_event.dart';
part 'shop_category_state.dart';

class ShopCategoryBloc extends Bloc<ShopCategoryEvent, ShopCategoryState> {
  ShopCategoryBloc() : super(ShopCategoryLoading());
  ShopCategory category=ShopCategory();
  @override
  Stream<ShopCategoryState> mapEventToState(ShopCategoryEvent event) async* {
    if(event is ShopCategoryInitial){
      yield ShopCategoryLoading();
      try{
        final List<String> list=await category.getShopCategory();
        yield ShopCategoryLoaded(list);
      }
      catch(e){
        yield ShopCategoryError();
      }
    }
  }
}

import 'package:eshop/features/fetch_wishlist/data/fetch_wishlist_repo.dart';
import 'package:eshop/features/fetch_wishlist/domain/fetch_wishlist_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_wishlist_event.dart';
part 'fetch_wishlist_state.dart';

class FetchWishlistBloc extends Bloc<FetchWishlistEvent, FetchWishlistState> {
  FetchWishlistBloc() : super(FetchWishlistInitial());
  final FetchWishlistRepo _repo=FetchWishlistRepo();
  @override
  Stream<FetchWishlistState> mapEventToState(FetchWishlistEvent event)async*{
    if(event is FetchWishListTriggerEvent){
      yield FetchWishlistLoading();
      try{
        final List<FetchWishListClass> list=await _repo.getWishlist(event.productID);
        if(list.first.productID=="product do not exist"){
          yield FetchWishlistEmpty();
        }
        else{
          yield FetchWishlistLoaded(list:list);
        }
      }
      catch(e){
        yield FetchWishlistError();
      }
    }
  }

}

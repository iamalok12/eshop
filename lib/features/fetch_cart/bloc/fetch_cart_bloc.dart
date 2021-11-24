import 'package:eshop/features/fetch_cart/data/fetch_cart.dart';
import 'package:eshop/features/fetch_cart/domain/fetch_cart_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_cart_event.dart';
part 'fetch_cart_state.dart';

class FetchCartBloc extends Bloc<FetchCartEvent, FetchCartState> {
  FetchCartBloc() : super(FetchCartInitial());
  final FetchCartRepo _repo=FetchCartRepo();
  @override
  Stream<FetchCartState> mapEventToState(FetchCartEvent event)async*{
    if(event is FetchCartTriggerEvent){
      yield FetchCartLoading();
      try{
        final List<FetchCartClass> list=await _repo.getCart(event.productID);
        if(list.first.productID=="product do not exist"){
          yield FetchCartEmpty();
        }
        else{
          yield FetchCartLoaded(list:list);
        }
      }
      catch(e){
        yield FetchCartError();
      }
    }
  }

}

import 'package:eshop/features/fetch_orders/data/fetch_order_seller_repo.dart';
import 'package:eshop/features/fetch_wishlist/bloc/fetch_wishlist_bloc.dart';
import 'package:eshop/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_order_seller_event.dart';
part 'fetch_order_seller_state.dart';

class FetchOrderSellerBloc extends Bloc<FetchOrderSellerEvent, FetchOrderSellerState> {
  FetchOrderSellerBloc() : super(FetchOrderSellerInitial());
  final FetchOrderSellerRepo _repo=FetchOrderSellerRepo();
  @override
  Stream<FetchOrderSellerState> mapEventToState(FetchOrderSellerEvent event)async*{
    if(event is FetchOrderTrigger){
      yield FetchOrderSellerLoading();
      try{
        final List<OrderModel> list=await _repo.getOrders();
        if(list.isEmpty){
          yield FetchOrderSellerEmpty();
        }
        else{
          list.sort((a,b)=>a.orderTime.compareTo(b.orderTime));
          yield FetchOrderSellerLoaded(list);
        }
      }
      catch(e){
        print(e);
        print("Invoking");
        yield FetchOrderSellerError();
      }
    }
  }
}

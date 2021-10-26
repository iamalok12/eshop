import 'dart:async';
import 'package:eshop/features/seller_profile/data/seller_profile.dart';
import 'package:eshop/features/seller_profile/domain/seller_profile_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seller_profile_event.dart';
part 'seller_profile_state.dart';

class SellerProfileBloc extends Bloc<SellerProfileEvent, SellerProfileState> {
  SellerProfileBloc() : super(SellerProfileInitial());

  final SellerProfileRepo _repo=SellerProfileRepo();

  @override
  Stream<SellerProfileState> mapEventToState(SellerProfileEvent event)async*{
    if(event is SellerProfileTrigger){
     try{
       yield SellerProfileLoading();
       final List<SellerProfileClass> list=await _repo.getData();
       if(list.isEmpty){
         yield SellerProfileError();
       }
       else{
         yield SellerProfileLoaded(list);
       }
     }
     catch(e){
       yield SellerProfileError();
     }
    }
  }
}

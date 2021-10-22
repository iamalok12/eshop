import 'dart:async';
import 'package:eshop/features/payment_status/data/payment_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_status_event.dart';
part 'payment_status_state.dart';

class PaymentStatusBloc extends Bloc<PaymentStatusEvent, PaymentStatusState> {
  PaymentStatusBloc() : super(PaymentStatusInitial());
    @override
    Stream<PaymentStatusState> mapEventToState(PaymentStatusEvent event)async*{
      if(event is PaymentStatusTrigger){
        yield PaymentStatusLoading();
        try{
          final bool isValid=await PaymentStatusRepo.getStatus();
          final List list=await PaymentStatusRepo.getOffer();
          if(isValid==true){
            yield PaymentStatusAlreadyValid();
          }
          else{
            if(list.isEmpty){
              yield PaymentStatusWithoutOffer();
            }
            else{
              final imageAddress=list[0] as String;
              final coupon=list[1] as String;
              final validity=list[2] as int;
              yield PaymentStatusWithOffer(imageAddress,coupon,validity);
            }
          }
        }
        catch(e){
          print(e);
          yield PaymentStatusError();
        }
      }
  }
}

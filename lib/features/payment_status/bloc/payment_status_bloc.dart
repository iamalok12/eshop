import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eshop/features/payment_status/data/payment_status.dart';
import 'package:flutter/cupertino.dart';
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
          final String offerAddress=await PaymentStatusRepo.getOffer();
          if(isValid==true){
            yield PaymentStatusAlreadyValid();
          }
          else{
            if(offerAddress==null){
              yield PaymentStatusWithoutOffer();
            }
            else{
              yield PaymentStatusWithOffer(offerAddress);
            }
          }
        }
        catch(e){
          yield PaymentStatusError();
        }
      }
  }
}

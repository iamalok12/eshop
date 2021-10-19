import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_status_event.dart';
part 'payment_status_state.dart';

class PaymentStatusBloc extends Bloc<PaymentStatusEvent, PaymentStatusState> {
  PaymentStatusBloc() : super(PaymentStatusInitial()) {
    on<PaymentStatusEvent>((event, emit) {

    });
  }
}

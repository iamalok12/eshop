part of 'payment_status_bloc.dart';

@immutable
abstract class PaymentStatusState {}

class PaymentStatusInitial extends PaymentStatusState {}

class PaymentStatusLoading extends PaymentStatusState {}

class PaymentStatusError extends PaymentStatusState {}

class PaymentStatusWithOffer extends PaymentStatusState {
  final String offerAddress;
  PaymentStatusWithOffer(this.offerAddress);
}

class PaymentStatusWithoutOffer extends PaymentStatusState {}

class PaymentStatusAlreadyValid extends PaymentStatusState {}

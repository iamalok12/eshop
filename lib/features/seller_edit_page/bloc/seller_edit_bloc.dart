import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'seller_edit_event.dart';
part 'seller_edit_state.dart';

class SellerEditBloc extends Bloc<SellerEditEvent, SellerEditState> {
  SellerEditBloc() : super(SellerEditInitial()) {
    on<SellerEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_items_event.dart';
part 'edit_items_state.dart';

class EditItemsBloc extends Bloc<EditItemsEvent, EditItemsState> {
  EditItemsBloc() : super(EditItemsInitial()) {
    on<EditItemsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'choose_city_event.dart';
part 'choose_city_state.dart';

class ChooseCityBloc extends Bloc<ChooseCityEvent, ChooseCityState> {
  ChooseCityBloc() : super(ChooseCityInitial());
  @override
  Stream<ChooseCityState> mapEventToState(ChooseCityEvent event) {

  }
}

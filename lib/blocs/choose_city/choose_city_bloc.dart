import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eshop/data/choose_city/choose_city.dart';
import 'package:meta/meta.dart';

part 'choose_city_event.dart';
part 'choose_city_state.dart';

class ChooseCityBloc extends Bloc<ChooseCityEvent, ChooseCityState> {
  ChooseCityBloc() : super(ChooseCityInitial());
  final ChooseCity _chooseCity=ChooseCity();
  @override
  Stream<ChooseCityState> mapEventToState(ChooseCityEvent event)async* {
    if(event is ChooseCityInitialEvent){
      yield ChooseCityLoading();
      try{
        final List<String> list=await _chooseCity.getCityList();
        yield ChooseCityLoaded(list);
      }
      catch(e){
        yield ChooseCityError();
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eshop/data/plans/plans.dart';
import 'package:meta/meta.dart';

part 'choose_plan_event.dart';
part 'choose_plan_state.dart';

class ChoosePlanBloc extends Bloc<ChoosePlanEvent, ChoosePlanState> {
  ChoosePlanBloc() : super(ChoosePlanInitial());
  final ChoosePlan _choosePlan=ChoosePlan();

  @override
  Stream<ChoosePlanState> mapEventToState(ChoosePlanEvent event)async* {
    if(event is ChoosePlanInitialEvent){
      yield ChoosePlanLoading();
      try{
        final List<int> list=await _choosePlan.getPlans();
        print(list[0]);
        yield ChoosePlanLoaded(list);
      }
      catch(e){
        yield ChoosePlanError();
      }
    }
  }
}

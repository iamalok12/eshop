import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eshop/features/choose_plan/data/choose_plan.dart';
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
        final List<int> list=await _choosePlan.fetchPlan();
        yield ChoosePlanLoaded(list);
      }
      catch(e){
        yield ChoosePlanError();
      }
    }
  }
}

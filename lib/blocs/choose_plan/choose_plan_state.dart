part of 'choose_plan_bloc.dart';

@immutable
abstract class ChoosePlanState {}

class ChoosePlanInitial extends ChoosePlanState {}

class ChoosePlanLoading extends ChoosePlanState{}

class ChoosePlanLoaded extends ChoosePlanState{
  final List<int> list;
  ChoosePlanLoaded(this.list);
}

class ChoosePlanError extends ChoosePlanState{}

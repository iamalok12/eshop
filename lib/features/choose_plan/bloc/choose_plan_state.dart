part of 'choose_plan_bloc.dart';

@immutable
abstract class ChoosePlanState {}

class ChoosePlanInitial extends ChoosePlanState {}

class ChoosePlanLoading extends ChoosePlanState{}

class ChoosePlanLoaded extends ChoosePlanState{
  final List<int> list;
  final String mobile;
  ChoosePlanLoaded(this.list, this.mobile);
}

class ChoosePlanError extends ChoosePlanState{}

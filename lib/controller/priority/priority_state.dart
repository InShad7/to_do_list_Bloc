part of 'priority_bloc.dart';

class PriorityState {
  bool priority ;
  PriorityState({required this.priority});
}

class PriorityInitial extends PriorityState {
  PriorityInitial():super(priority: false);
}

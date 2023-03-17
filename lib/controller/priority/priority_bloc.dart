import 'package:bloc/bloc.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:meta/meta.dart';

part 'priority_event.dart';
part 'priority_state.dart';

class PriorityBloc extends Bloc<PriorityEvent, PriorityState> {
  PriorityBloc() : super(PriorityInitial()) {


    on<AddPriority>((event, emit) {
      return emit(PriorityState(priority: newPriority));
    });


    on<InitialPriority>((event, emit) {
      return emit(PriorityState(priority:false));
    });


  }
}

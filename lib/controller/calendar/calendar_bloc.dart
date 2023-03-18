import 'package:bloc/bloc.dart';
import 'package:just_do_it/screens/calendarScreen.dart';
import 'package:meta/meta.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<FocusedDay>(
      (event, emit) {
        return emit(
            CalendarState(focusedDay: focusedDay, selsectedDay: selectedDay));
      },
    );

    on<Selected>(
      (event, emit) {
        return emit(
            CalendarState(focusedDay: focusedDay, selsectedDay: focusedDay));
      },
    );

    

  }
}

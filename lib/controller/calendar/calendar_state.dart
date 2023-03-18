part of 'calendar_bloc.dart';

class CalendarState {
  DateTime selsectedDay, focusedDay;

  CalendarState({required this.focusedDay,required this.selsectedDay});
}

class CalendarInitial extends CalendarState {
  CalendarInitial() : super(focusedDay: DateTime.now(),selsectedDay: DateTime.now());
}

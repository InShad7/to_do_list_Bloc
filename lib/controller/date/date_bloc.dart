import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/screens/editTask.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(DateInitial()) {
    on<SelectDate>((event, emit) {
      return emit(DateState(nDate: newDateTime));
    });

    on<Initial>((event, emit) {
      return emit(DateState(nDate: dateTime));
    });

    on<EditDateTime>((event, emit) {
      return emit(DateState(nDate: dateTime));
    });

  }
}

part of 'date_bloc.dart';

class DateState {
  DateTime? nDate;
  DateState({required this.nDate});
}

class DateInitial extends DateState {
  DateInitial():super(nDate: DateTime.now());
}

part of 'search_bloc.dart';

class SearchEvent {}

class InitialSearch extends SearchEvent {
  // String value;
  // SearchValue({required this.value});
}

class UpdateSearch extends SearchEvent {
  String val;
  UpdateSearch({required this.val});
}

class IsSelected extends SearchEvent {}

class UnSelected extends SearchEvent {}

class NewDate extends SearchEvent {
  final DateTimeRange? newDatePickBloc;
  NewDate({required this.newDatePickBloc});
}

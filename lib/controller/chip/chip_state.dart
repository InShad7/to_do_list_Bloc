part of 'chip_bloc.dart';

class ChipState {
  String filtervalue;
  ChipState({required this.filtervalue});
}

class ChipInitial extends ChipState {
  ChipInitial():super(filtervalue: '');
}

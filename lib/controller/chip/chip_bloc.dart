import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_do_it/model/data_model.dart';
import 'package:just_do_it/screens/search.dart';

part 'chip_event.dart';
part 'chip_state.dart';

class ChipBloc extends Bloc<ChipEvent, ChipState> {
  ChipBloc() : super(ChipInitial()) {
    on<IsSelected>((event, emit) {
      List<Task> values = Hive.box<Task>('task_db').values.toList();
      final selectedChip = values
          .where(
            (element) =>
                element.priority == false &&
                element.title.toLowerCase().contains(searchController.text),
          )
          .toList();
      // log(selectedChip.toString());
      return emit(ChipState(filtervalue: selectedChip.toString()));
    });
    // log(filter);

    on<UnSelected>((event, emit) {
      return emit(ChipState(filtervalue: ''));
    });
  }
}

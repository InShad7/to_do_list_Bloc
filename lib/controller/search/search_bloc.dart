import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_do_it/model/data_model.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/screens/search.dart';
import 'package:just_do_it/widgets/filterChips.dart';
import 'package:just_do_it/widgets/filterChips.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<InitialSearch>((event, emit) {
      List<Task> values = Hive.box<Task>('task_db').values.toList();
      List<Event> eventValues = Hive.box<Event>('event_db').values.toList();

      emit(SearchState(
        searchResult: values,
        taskList: values,
        eventList: eventValues,
        eventSearch: eventValues,
        taskchip: values,
        Evntchip: eventValues,
        listDatechip: [],
      ));
    });

    on<UpdateSearch>((event, emit) {
      List<Task> values = Hive.box<Task>('task_db').values.toList();
      List<Task> sortedValue = values.where((element) {
        final taskName = element.title.toLowerCase();
        final searchBy = event.val.toLowerCase();

        return taskName.contains(searchBy);
      }).toList();

      List<Event> eventValues = Hive.box<Event>('event_db').values.toList();
      List<Event> EventsortedValue = eventValues.where((element) {
        final eventName = element.title.toLowerCase();
        final searchBy = event.val.toLowerCase();

        return eventName.contains(searchBy);
      }).toList();

      if (sortedValue.isEmpty && EventsortedValue.isEmpty) {
        emit(SearchState(
            taskList: [],
            searchResult: [],
            eventList: [],
            eventSearch: [],
            Evntchip: [],
            taskchip: [],
            listDatechip: []));
      } else {
        emit(SearchState(
          taskList: values,
          searchResult: sortedValue,
          eventList: EventsortedValue,
          eventSearch: EventsortedValue,
          taskchip: values,
          Evntchip: EventsortedValue,
          listDatechip: [],
        ));
      }

      // on<InitialVal2>((event, emit) {
      //   return emit(SearchState(value: eventList.toString()));
      // });
    });

    on<IsSelected>((event, emit) {
      List<Task> values = Hive.box<Task>('task_db').values.toList();
      List<Event> eventValues = Hive.box<Event>('event_db').values.toList();
      if (filter == 'high') {
        final high = values
            .where(
              (element) =>
                  element.priority == true &&
                  element.title.toLowerCase().contains(searchController.text),
            )
            .toList();
        final evenHigh = eventValues
            .where(
              (element) =>
                  element.priority == true &&
                  element.title.toLowerCase().contains(searchController.text),
            )
            .toList();
        emit(
          SearchState(
            searchResult: high,
            taskList: high,
            eventList: evenHigh,
            eventSearch: evenHigh,
            taskchip: high,
            Evntchip: evenHigh,
            listDatechip: [],
          ),
        );
      } else if (filter == 'low') {
        final low = values
            .where(
              (element) =>
                  element.priority == false &&
                  element.title.toLowerCase().contains(searchController.text),
            )
            .toList();

        final evenLow = eventValues
            .where(
              (element) =>
                  element.priority == false &&
                  element.title.toLowerCase().contains(searchController.text),
            )
            .toList();

        emit(
          SearchState(
            searchResult: low,
            taskList: low,
            eventList: evenLow,
            eventSearch: evenLow,
            taskchip: low,
            Evntchip: evenLow,
            listDatechip: [],
          ),
        );
      }
      //  else if (filter == 'date') {
      //   log(newDatePick.toString());
      //   List<Task> date = values.where((Task) {
      //     return DateTime.parse(Task.date.toString()).day ==
      //             newDatePick.toString() &&
      //         DateTime.parse(Task.date.toString()).month ==
      //             newDatePick.toString() &&
      //         DateTime.parse(Task.date.toString()).year ==
      //             newDatePick.toString();
      //   }).toList();
      //   emit(
      //     SearchState(
      //         taskList: date,
      //         searchResult: date,
      //         eventList: eventList,
      //         eventSearch: eventList,
      //         taskchip: date,
      //         Evntchip: eventValues,
      //         listDatechip: date),
      //   );
      // }

      // log(high.toString());
    });

    on<UnSelected>((event, emit) {
      List<Task> values = Hive.box<Task>('task_db').values.toList();
      List<Event> eventValues = Hive.box<Event>('event_db').values.toList();

      emit(
        SearchState(
            searchResult: values,
            taskList: values,
            eventList: eventValues,
            eventSearch: eventValues,
            taskchip: values,
            Evntchip: eventValues,
            listDatechip: values),
      );
    });

    on<NewDate>((event, emit) {
      List<Task> values = Hive.box<Task>('task_db').values.toList();
      List<Event> eventValues = Hive.box<Event>('event_db').values.toList();
      // if (filter == 'date') {
      if (event is NewDate) {
        final startDate = event.newDatePickBloc!.start;
        // log(startDate.toString());
        final endDate = event.newDatePickBloc!.end;
        // log(endDate.toString());
        // log(event.newDatePickBloc.toString());
        final date = values.where((Task task) {
          final taskDate = DateTime.parse(task.date.toString());
          return taskDate.isAfter(
                  DateTime(startDate.year, startDate.month, startDate.day)) &&
              taskDate.isBefore(
                  DateTime(endDate.year, endDate.month, endDate.day + 1));
        }).toList();
        // log(date.toString());
        final eventdate = eventValues.where((Event task) {
          final taskDate = DateTime.parse(task.date.toString());
          return taskDate.isAfter(
                  DateTime(startDate.year, startDate.month, startDate.day)) &&
              taskDate.isBefore(
                  DateTime(endDate.year, endDate.month, endDate.day + 1));
        }).toList();

        emit(
          SearchState(
            taskList: date,
            searchResult: date,
            eventList: eventdate,
            eventSearch: eventdate,
            taskchip: date,
            Evntchip: eventdate,
            listDatechip: date,
            
          ),
        );
      }
      // }
    });
  }
}

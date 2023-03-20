part of 'search_bloc.dart';

class SearchState {
  List<Task> taskList;
  List<Task> searchResult;
  List<Event> eventList;
  List<Event> eventSearch;
  List<Task> taskchip;
  List<Event> Evntchip;
  List<Task> listDatechip;
  SearchState(
      {required this.taskList,
      required this.searchResult,
      required this.eventList,
      required this.eventSearch,
      required this.taskchip,
      required this.Evntchip,
      required this.listDatechip});
}

class SearchInitial extends SearchState {
  SearchInitial()
      : super(
          searchResult: [],
          taskList: [],
          eventList: [],
          eventSearch: [],
          taskchip: [],
          Evntchip: [],
          listDatechip: [],
        );
}

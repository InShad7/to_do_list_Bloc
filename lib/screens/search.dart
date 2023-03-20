import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
// import 'package:just_do_it/controller/chip/chip_bloc.dart';
import 'package:just_do_it/controller/search/search_bloc.dart';
import 'package:just_do_it/function/db_event_function.dart';
import 'package:just_do_it/model/data_model.dart';
import 'package:just_do_it/screens/EventView.dart';
import 'package:just_do_it/screens/taskView.dart';
import 'package:just_do_it/utilities/Colors.dart';
import 'package:intl/intl.dart';
import 'package:just_do_it/utilities/globalFunctions.dart';
import 'package:just_do_it/widgets/filterChips.dart';
import 'package:just_do_it/widgets/searchField.dart';
import '../function/db_function.dart';
import '../widgets/sizedbox.dart';

final searchController = TextEditingController();
DateTimeRange? newDateTime;
String filter = '';

List<Task> taskList = Hive.box<Task>('task_db').values.toList();

late List<Task> taskDisplay = List<Task>.from(taskList);

List<Event> eventList = Hive.box<Event>('event_db').values.toList();

late List<Event> eventDisplay = List<Event>.from(eventList);

DateTimeRange dateRange =
    DateTimeRange(start: DateTime.now(), end: DateTime.now());

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  // Task passValue;
  late DateTime dateTime = DateTime.now();

  var taskEventKey = 0;

  // final searchController = TextEditingController();

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Task'),
    const Tab(text: 'Event'),
  ];

  void clearText() {
    searchController.clear();
  }

//<<<<<<<<<<<<--------------priority and date--------------->>>>>>>>>>>>>>>>>>>>>>
  Padding PriorityAndDate(bool myPriority, DateTime mydate) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          prior(myPriority),
          const szdbx(ht: 10),
          Text(DateFormat("dd MMM yyyy hh:mm a").format(mydate),
              // mydate.substring(0, mydate.length - 7),
              style: TextStyle(color: Grey())),
        ],
      ),
    );
  }

  prior(mypriorityval) {
    if (mypriorityval == true) {
      return Container(
        child: const Icon(
          Icons.circle,
          color: Colors.red,
          size: 12,
        ),
      );
    } else {
      return Container(
        child: const Icon(
          Icons.circle,
          color: Colors.amber,
          size: 12,
        ),
      );
    }
  }

  BoxDecoration MyBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: ThemeGrey(),
    );
  }

  TabBarView TabBarList() {
    return TabBarView(children: [
      Column(
        children: [
          const szdbx(ht: 100),
          // yourTask('Your tasks'),
          Expanded(
            child: TaskSearchList(),
          ),
        ],
      ),
      Column(children: [
        const szdbx(ht: 100),
        // yourTask('Your Events'),
        Expanded(
          child: EventSearchList(),
        ),
      ]),
    ]);
  }

  AppBar MyAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      bottom: TabBar(
        // indicatorColor: Transprt(),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: myTabs,
      ),
      backgroundColor: Black(),
      title: const SearchInputField(),
      //  SearchInputField(searchFun:searchTask(searchController.text, newDateTime)),
      // searchTextField()
      // actions: [appBarAction()],
    );
  }

  Widget EventSearchList() {
    // getTask();
    getEvent();
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return state.eventSearch.isNotEmpty
          ?
          // ValueListenableBuilder(
          //     valueListenable: eventNotifier,
          //     builder: (BuildContext context, dynamic value, Widget? child) {
          // getTask();
          // getEvent();
          SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.eventSearch.length,
                      itemBuilder: ((context, index) {
                        state.eventSearch.sort(
                            (Event a, Event b) => a.date.compareTo(b.date));
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 6),
                          child: Container(
                            decoration: MyBoxDecoration(),
                            child: Slidable(
                              startActionPane: ActionPane(
                                motion: BehindMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      markDoneE(
                                          state.eventSearch[index], context);
                                      doneToast();
                                    },
                                    backgroundColor:
                                        Color.fromARGB(255, 120, 181, 122),
                                    icon: Icons.check_rounded,
                                    label: 'Done',
                                  ),
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: BehindMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      // if (taskEventKey == 1) {
                                      // deleteTask(index);
                                      deleteEvents(state.eventSearch[index].id);
                                      deleteToast();
                                      // Navigator.of(context).pop();
                                      // }
                                    },
                                    backgroundColor:
                                        Color.fromARGB(255, 213, 78, 68),
                                    icon: Icons.close_rounded,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.only(
                                    left: 20, top: 10, bottom: 10),
                                title: Text(
                                  state.eventSearch[index].title,
                                  style: TextStyle(color: White()),
                                ),
                                subtitle: PriorityAndDate(
                                    state.eventSearch[index].priority,
                                    state.eventSearch[index].date),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) => eventView(
                                        passValue: state.eventSearch[index],
                                        passId: index,
                                        passDate: state.eventSearch[index].date,
                                        taskEventKey: taskEventKey,
                                        priority:
                                            state.eventSearch[index].priority)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
                ],
              ),
            )
          // })
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 120.0),
                  child: Text(
                    'No Match Found',
                    style: TextStyle(color: Grey(), fontSize: 23),
                  ),
                ),
              ],
            );
    });
  }

  Widget TaskSearchList() {
    getTask();
    // getEvent();
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return state.searchResult.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 120.0),
                  child: Text(
                    'No Match Found',
                    style: TextStyle(color: Grey(), fontSize: 23),
                  ),
                ),
              ],
            )
          :
          // ValueListenableBuilder(
          //     valueListenable: taskNotifier,
          //     builder: (BuildContext context, dynamic value, Widget? child) {
          //       getTask();
          // getEvent();
          // return
          SingleChildScrollView(
              child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.searchResult.length,
                    itemBuilder: ((context, index) {
                      // final data = taskList[index];
                      state.searchResult
                          .sort((Task a, Task b) => a.date.compareTo(b.date));
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 6),
                        child: Container(
                          decoration: MyBoxDecoration(),
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    markDoneT(
                                        state.searchResult[index], context);
                                    doneToast();
                                  },
                                  backgroundColor:
                                      Color.fromARGB(255, 120, 181, 122),
                                  icon: Icons.check_rounded,
                                  label: 'Done',
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    // if (taskEventKey == 0) {
                                    deleteTask(state.searchResult[index].id);
                                    deleteToast();
                                    // }
                                  },
                                  backgroundColor:
                                      Color.fromARGB(255, 213, 78, 68),
                                  icon: Icons.close_rounded,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10),
                              title: Text(
                                state.searchResult[index].title,
                                style: TextStyle(color: White()),
                              ),
                              subtitle: PriorityAndDate(
                                  state.searchResult[index].priority,
                                  state.searchResult[index].date),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) => taskView(
                                        passValue: state.searchResult[index],
                                        passId: index,
                                        passDate:
                                            state.searchResult[index].date,
                                        taskEventKey: taskEventKey,
                                        priority:
                                            state.searchResult[index].priority,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }))
              ],
            )
              //   },
              // ),
              );

      // })
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(InitialSearch());
      BlocProvider.of<SearchBloc>(context).add(IsSelected());
      // BlocProvider.of<SearchBloc>(context).add();
    });
    getTask();
    getEvent();
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: MyAppBar(),
        backgroundColor: Black(),
        body: Stack(
          children: [
            TabBarList(),
            const FilterChips()
            // techChips(),
          ],
        ),
      ),
    );
  }
}

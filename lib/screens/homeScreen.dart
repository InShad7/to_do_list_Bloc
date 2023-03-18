import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:just_do_it/function/DB_Event_Function.dart';
import 'package:just_do_it/function/db_function.dart';
import 'package:just_do_it/screens/addEvent.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/screens/dashBoard.dart';
import 'package:just_do_it/screens/navigationDrawer.dart';
import 'package:just_do_it/screens/search.dart';
import 'package:just_do_it/utilities/yourTasksField.dart';
import 'package:just_do_it/utilities/Colors.dart';
import 'package:just_do_it/widgets/EventList.dart';
import 'package:just_do_it/widgets/sizedbox.dart';
import 'package:just_do_it/widgets/taskList.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  // Task passValue;

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Task'),
    const Tab(text: 'Event'),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   // SystemChrome.setEnabledSystemUIOverlays([]);
  // }

  Widget floatBtn(context) {
    return SpeedDial(
      // animatedIcon: AnimatedIcons.menu_close,
      overlayColor: Black(),
      overlayOpacity: 0,
      spacing: 5,
      spaceBetweenChildren: 5,
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: OrangeColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        SpeedDialChild(
            child: Icon(
              Icons.edit_outlined,
              size: 28,
              color: White(),
            ),
            label: 'Add Task',
            backgroundColor: OrangeColor(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => addTask())),
                )),
        SpeedDialChild(
            child: const Icon(
              Icons.event_rounded,
              size: 28,
              color: Colors.white,
            ),
            label: 'Add Event',
            backgroundColor: OrangeColor(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => addEvent())),
                ))
      ],
    );
  }

  AppBar MyAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      bottom: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        tabs: myTabs,
      ),
      backgroundColor: Black(),
      title: InkWell(
        onTap: () => _scaffoldKey.currentState!.openDrawer(),
        child: const Text(
          'Just Do It.',
          style: TextStyle(
              letterSpacing: 2, fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [appBarAction(context)],
    );
  }

  Widget appBarAction(context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            size: 34,
          ),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => search()))),
        ),
        IconButton(
            alignment: Alignment.topCenter,
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DashBoard())),
            icon: const Icon(
              Icons.person_rounded,
              size: 34,
            ))
      ],
    );
  }

  Positioned FloatBtnPosition(context) =>
      Positioned(bottom: 30, right: 30, child: floatBtn(context));

  TabBarView TabBarList(BuildContext context) {
    return TabBarView(children: [
      Column(
        children: [
          const szdbx(ht: 100),
          YourTasks(context: context, mylistName: "Today's Tasks"),
          const szdbx(ht: 10),
          Expanded(
            child: TaskList(
              taskEventKey: 0,
            ),
          ),
        ],
      ),
      Column(children: [
        const szdbx(ht: 100),
        YourTasks(context: context, mylistName: "Today's Events"),
        Expanded(
          child: EventList(
            taskEventKey: 1,
          ),
        ),
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // checkTimeForNotification();
    getTask();
    getEvent();
    return DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
            key: _scaffoldKey,
            drawer: NavigationDrawer(),
            backgroundColor: Black(),
            appBar: MyAppBar(context),
            body: Stack(children: [TabBarList(context), FloatBtnPosition(context)])));
    // );
  }
}

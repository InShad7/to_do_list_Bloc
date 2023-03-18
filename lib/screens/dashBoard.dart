import 'package:flutter/material.dart';
import 'package:just_do_it/screens/dashBoardEvent.dart';
import 'package:just_do_it/utilities/colors.dart';
import 'package:just_do_it/widgets/completedTask.dart';
import 'package:just_do_it/widgets/pendingTasks.dart';
import 'package:just_do_it/widgets/sizedbox.dart';


class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);


  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Pending'),
    const Tab(text: 'Completed'),
  ];

  TabBarView tabBarList() {
    return TabBarView(children: [
      Column(
        children: [
          const szdbx(ht: 50),
          // yourTask('Your Tasks'),
          // const szdbx(ht: 10),
          Expanded(child: PendingTask(taskEventKey: 0)),
        ],
      ),
      Column(children: [
        const szdbx(ht: 50),
        // yourTask('Your Events'),
        Expanded(child: CompletedTask()),
      ]),
    ]);
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      bottom: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        tabs: myTabs,
      ),
      title: Text(
        'Tasks.',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Black(),
      actions: [
        InkWell(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => DashBoardEvent()))),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 15.0),
            child: Text(
              'Events',
              style: TextStyle(color: Grey(), fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Black(),
            appBar: myAppBar(context),
            body: Column(children: [Expanded(child: tabBarList())])));
  }
}

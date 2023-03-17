
import 'package:flutter/material.dart';
import 'package:just_do_it/function/db_function.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:just_do_it/function/db_function.dart';
import 'package:just_do_it/model/data_model.dart';
// import 'package:just_do_it/screens/editEvent.dart';
import 'package:just_do_it/screens/editTask.dart';
import 'package:just_do_it/screens/search.dart';
import 'package:just_do_it/utilities/Colors.dart';
import 'package:just_do_it/utilities/date.dart';
import 'package:just_do_it/utilities/globalFunctions.dart';
import 'package:just_do_it/utilities/textField.dart';
// import 'package:just_do_it/widgets/delete.dart';
import 'package:just_do_it/widgets/sizedbox.dart';
import 'package:intl/intl.dart';

class taskView extends StatelessWidget {
  taskView(
      {Key? key,
      required this.passId,
      required this.passValue,
      required this.passDate,
      required this.taskEventKey,
      required this.priority})
      : super(key: key);

  Task passValue;
  final int passId;
  final passDate;
  final taskEventKey;
  final priority;

  DateTime dateTime = DateTime.now();

  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

  AppBar MyAppBar(context) {
    return AppBar(
      actions: [appbarAction(context)],
      backgroundColor: Black(),
    );
  }

  Widget appbarAction(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Row(children: [
        // IconButton(
        //     onPressed: () {
        //       deleteTask(widget.passValue.id);
        //       Navigator.of(context).pop();
        //     },
        //     // => Navigator.of(context).push(MaterialPageRoute(
        //     //     builder: ((context) => editTask(
        //     //           passId: widget.passId,
        //     //           passValue: widget.passValue,
        //     //         )))),
        //     icon: Icon(
        //       Icons.delete_outline_rounded,
        //       size: 30,
        //     )),
        IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => editTask(
                      passId: passId,
                      passValue: passValue,
                    )))),
            icon:const Icon(
              Icons.edit_outlined,
              size: 30,
            )),
        // ],
        
      ]),
    );
  }

  Padding PriorityAndDate() {
    return Padding(
      padding: const EdgeInsets.only(right: 17.0, left: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          priorityDisplay(priority),
          MyDate(passDate: passDate),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Black(),
        appBar: MyAppBar(context),
        body: ListView(
          children: [
            const szdbx(ht: 80),
            PriorityAndDate(),
            const szdbx(ht: 10),
            MyTextField(hintName: passValue.title, ht: 72),
            MyTextField(hintName: passValue.content, ht: 400),
            const szdbx(ht: 80),
          ],
        ));
  }
}

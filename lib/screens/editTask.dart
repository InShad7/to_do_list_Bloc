import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_do_it/controller/date/date_bloc.dart';
import 'package:just_do_it/controller/priority/priority_bloc.dart';
import 'package:just_do_it/function/db_function.dart';
import 'package:just_do_it/model/data_model.dart';
import 'package:just_do_it/screens/HomeScreen.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/utilities/Colors.dart';
import 'package:just_do_it/utilities/textfieldForm.dart';
import 'package:just_do_it/widgets/editDate.dart';
import 'package:just_do_it/widgets/editTime.dart';
import 'package:just_do_it/widgets/priority.dart';

import 'package:just_do_it/widgets/sizedbox.dart';

bool? editPriority;

class editTask extends StatelessWidget {
  editTask({
    Key? key,
    required this.passId,
    required this.passValue,
  }) : super(key: key);

  late Task passValue;
  final int passId;

  late final _titleController = TextEditingController(text: passValue.title);

  late final _contentController =
      TextEditingController(text: passValue.content);

  Future<void> TaskAddBtnEdit(int index, context) async {
    final _title = _titleController.text.trim();
    final _content = _contentController.text.trim();
    final _dateTime = newDateTime;
    final _isComplete = false;
    final _id = DateTime.now().toString();

    if (_title.isEmpty) {
      return;
    }
    print('$_title $_content $dateTime');

    final _tasks = Task(
      title: _title,
      content: _content,
      date: _dateTime == null ? DateTime.now() : newDateTime,
      priority: newPriority,
      // isCompleted: _isComplete,
      id: _id,
      isCompleted: false,
      // time: dateTime,
    );

    editTasks(passValue.id, context, _tasks);
  }



  AppBar MyAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Black(),
      actions: [
        AppBarActions(context),
      ],
    );
  }

  Row AppBarActions(
    BuildContext context,
  ) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              TaskAddBtnEdit(passId, context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: ((context) => HomeScreen())),
                  (route) => false);
            },
            icon: const Icon(
              Icons.check_rounded,
              size: 32,
            )),
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close_rounded,
              size: 32,
            ))
      ],
    );
  }

  // var myPriority = false;

  onChangeFunction(bool newValue, context) {
    newPriority = !newPriority;
    BlocProvider.of<PriorityBloc>(context).add(AddPriority());
    // setState(() {
    //   myPriority = newValue;
    // });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PriorityBloc>(context).add(EditPriority());
      BlocProvider.of<DateBloc>(context).add(EditDateTime());
    });
    dateTime = passValue.date;
    editPriority = passValue.priority;

    return Scaffold(
        backgroundColor: Black(),
        appBar: MyAppBar(context),
        body: ListView(
          children: [
            const szdbx(ht: 100),
            MyTextFieldForm(myController: _titleController, hintName: 'Title'),
            MyTextFieldForm(
                myController: _contentController, hintName: 'Content'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EditDate(passValue: passValue),
                EditTime(passValue: passValue),
                // date(context),
                // time(context),
              ],
            ),
            PriorityBtn(
                isSwitched: newPriority, onChangeMethod: onChangeFunction),
          ],
        ));
  }
}

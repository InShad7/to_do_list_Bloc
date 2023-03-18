import 'package:flutter/material.dart';
import 'package:just_do_it/function/db_function.dart';
import 'package:just_do_it/model/data_model.dart';
import 'package:just_do_it/screens/addEvent.dart';

import '../screens/addTask.dart';

class myAppBar extends StatelessWidget {
  myAppBar(
      {super.key,
      required this.titleController,
      required this.contentController});

  var titleController = TextEditingController();

  var contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              TaskAddBtn();
              // BlocProvider.of<DateBloc>(context).add(clear());
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.check_rounded,
              size: 32,
            )),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              size: 32,
            ))
      ],
    );
  }

  Future<void> TaskAddBtn() async {
    final _title = titleController.text.trim();
    final _content = contentController.text.trim();
    final _dateTime = newDateTime;
    final _isComplete = false;
    final _id = DateTime.now().toString();
    // myTaskId = _id;

    if (_title.isEmpty) {
      return;
    }

    print('$_title $_content $dateTime');

    final _tasks = Task(
      // isCompleted: false,
      title: _title,
      content: _content,
      date: _dateTime == null ? DateTime.now() : newDateTime,
      priority: newPriority,
      id: _id,
      isCompleted: false,
    );
    addTasks(_tasks);

    // final _events = Event(
    //   title: _title,
    //   content: _content,
    //   date: _dateTime,
    //   image: PickedFile.path,
    //   priority: newPriority,
    //   id: _id,
    //   isCompleted: false,
    // );
    // addEvents(_events);
  }
}

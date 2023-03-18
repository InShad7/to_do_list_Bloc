import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_do_it/function/db_event_function.dart';
import 'package:just_do_it/model/data_model.dart';
import 'package:just_do_it/screens/addEvent.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/widgets/addImage.dart';

class EventAppBar extends StatelessWidget {
  const EventAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              TaskAddBtn();
              Navigator.of(context).pop();
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
}

 Future<void> TaskAddBtn() async {
    final _title = titleControllerEvent.text.trim();
    final _content = contentControllerEvent.text.trim();
    final _dateTime = newDateTime;
    final _id = DateTime.now().toString();
    myEventId = _id;

    if (_title.isEmpty) {
      return;
    }
    print('$_title $_content $dateTime');

    final _events = Event(
      title: _title,
      content: _content,
      date: _dateTime == null ? DateTime.now() : newDateTime,
      image: pickedFile!.path,
      priority: newPriority,
      id: _id,
      isCompleted: false,
    );
    addEvents(_events);
  }
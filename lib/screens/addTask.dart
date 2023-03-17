// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_do_it/controller/date/date_bloc.dart';
import 'package:just_do_it/controller/priority/priority_bloc.dart';
import 'package:just_do_it/function/db_function.dart';
import 'package:just_do_it/model/data_model.dart';
import 'package:just_do_it/utilities/Colors.dart';
import 'package:just_do_it/utilities/textfieldForm.dart';
import 'package:just_do_it/widgets/priority.dart';
// import 'package:just_do_it/widgets/prioritySwitch.dart';
import 'package:just_do_it/widgets/sizedbox.dart';
import 'package:intl/intl.dart';

// bool isSwitched = false;

String? myTaskId;

dynamic newDateTime;

bool newPriority = false;

// dynamic newTime;
// dynamic dTime;

class addTask extends StatelessWidget {
  addTask({Key? key}) : super(key: key);

  // bool isSwitched = false;
  DateTime? dateTime;

  // DateTime? newDateTime;
  // String formattedDate = DateFormat('yyyy-MM-dd - hh:mm').format(dateTime);
  // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

  // final id = int;

  String? imagepath;

  Future<void> TaskAddBtn() async {
    final _title = _titleController.text.trim();
    final _content = _contentController.text.trim();
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
  }

  final DateBloc _dateBloc = DateBloc();

  Widget date(context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<DateBloc>(context).add(Initial());
    });

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<DateBloc, DateState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ThemeGrey(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(25)),
            onPressed: () async {
              dateTime = state.nDate;
              final date = await pickDate(context);
              if (date == null) return;

              newDateTime = DateTime(
                  date.year, date.month, date.day, date.hour, date.minute);
              // print(newDateTime);

              BlocProvider.of<DateBloc>(context).add(
                SelectDate(),
              );
            },
            child: Text(
              '${state.nDate!.year}/${state.nDate!.month}/${state.nDate!.day}',
              style: TextStyle(color: Grey()),
            ),
          );
        },
      ),
    );
  }

  Future<DateTime?> pickDate(context) => showDatePicker(
      context: context,
      initialDate: dateTime!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2500));

  Widget time(context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<DateBloc>(context).add(Initial());
    });
    final hours = dateTime?.hour.toString().padLeft(2, '0');
    final minutes = dateTime?.minute.toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<DateBloc, DateState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ThemeGrey(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(25)),
            onPressed: () async {
              dateTime = state.nDate;
              final time = await pickTime(context);
              if (time == null) return;

              newDateTime = DateTime(dateTime!.year, dateTime!.month,
                  dateTime!.day, time.hour, time.minute);

              BlocProvider.of<DateBloc>(context).add(SelectDate());
              // print(newDateTime);
              // setState(() {
              //   dateTime = newDateTime;
              // });
            },
            child: Text(
              '${state.nDate!.hour}:${state.nDate!.minute}',
              style: TextStyle(color: Grey()),
            ),
          );
        },
      ),
    );
  }

  Future<TimeOfDay?> pickTime(context) => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

  // bool myPriority = false;

  onChangeFunction(bool newValue, context) {
    newPriority = !newPriority;
    BlocProvider.of<PriorityBloc>(context).add(AddPriority());
    // setState(() {
    //   myPriority = newValue;
    // });
  }

  Row DateAndTime(
    context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        date(context),
        time(context),
      ],
    );
  }

  AppBar MyAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Black(),
      actions: [
        AppBarActions(context),
      ],
    );
  }

  Row AppBarActions(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<PriorityBloc>(context).add(InitialPriority());
    });
    return Scaffold(
      backgroundColor: Black(),
      appBar: MyAppBar(context),
      body: ListView(
        children: [
          const szdbx(ht: 100),
          MyTextFieldForm(myController: _titleController, hintName: 'Tittle'),
          MyTextFieldForm(
              myController: _contentController, hintName: 'Content'),
          DateAndTime(context),
          const szdbx(ht: 10),
           PriorityBtn(
                  isSwitched: newPriority, onChangeMethod: onChangeFunction)
          
          // priority(myPriority, onChangeFunction),
        ],
      ),
    );
  }
}

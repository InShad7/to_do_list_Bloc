import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_do_it/controller/priority/priority_bloc.dart';
import 'package:just_do_it/utilities/Colors.dart';
import 'package:just_do_it/utilities/textfieldForm.dart';
import 'package:just_do_it/widgets/appbar.dart';
import 'package:just_do_it/widgets/date.dart';
import 'package:just_do_it/widgets/priority.dart';
import 'package:just_do_it/widgets/sizedbox.dart';
import 'package:just_do_it/widgets/time.dart';

// bool isSwitched = false;

String? myTaskId;

dynamic newDateTime;

bool newPriority = false;

DateTime dateTime=DateTime.now();

class addTask extends StatelessWidget {
  addTask({Key? key}) : super(key: key);

  final contentControl = TextEditingController();
  final titleControl = TextEditingController();

  onChangeFunction(bool newValue, context) {
    newPriority = !newPriority;
    BlocProvider.of<PriorityBloc>(context).add(AddPriority());
    // setState(() {
    //   myPriority = newValue;
    // });
  }

  Row dateAndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        selectDate(),
        selectTime(),
      ],
    );
  }

  AppBar myyAppBar() {
    return AppBar(
      backgroundColor: Black(),
      actions: [
        myAppBar(
          contentController: contentControl,
          titleController: titleControl,
        )
        // AppBarActions(context),
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
      appBar: myyAppBar(),
      body: ListView(
        children: [
          const szdbx(ht: 100),
          MyTextFieldForm(myController: titleControl, hintName: 'Tittle'),
          MyTextFieldForm(myController: contentControl, hintName: 'Content'),
          dateAndTime(),
          const szdbx(ht: 10),
          PriorityBtn(isSwitched: newPriority, onChangeMethod: onChangeFunction)

          // priority(myPriority, onChangeFunction),
        ],
      ),
    );
  }
}

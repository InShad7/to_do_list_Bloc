
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_do_it/controller/img/img_bloc.dart';
import 'package:just_do_it/controller/priority/priority_bloc.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/utilities/Colors.dart';
import 'package:just_do_it/utilities/textfieldForm.dart';
import 'package:just_do_it/widgets/addImage.dart';
import 'package:just_do_it/widgets/appbarEvent.dart';
import 'package:just_do_it/widgets/date.dart';
import 'package:just_do_it/widgets/priority.dart';
import 'package:just_do_it/widgets/sizedbox.dart';
import 'package:just_do_it/widgets/time.dart';

String? myEventId;

var titleControllerEvent = TextEditingController();

var contentControllerEvent = TextEditingController();

class addEvent extends StatelessWidget {
  addEvent({Key? key}) : super(key: key);
  DateTime? dateTime;

 

  onChangeFunction(bool newValue, context) {
    newPriority = !newPriority;
    BlocProvider.of<PriorityBloc>(context).add(AddPriority());
    // setState(() {
    //   myPriority = newValue;
    // });
  }

  Row DateAndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        selectDate(),
        selectTime(),
      ],
    );
  }

  AppBar MyAppBar(context) {
    return AppBar(
      backgroundColor: Black(),
      actions: const [
        EventAppBar(),
        // AppBarActions(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
       BlocProvider.of<PriorityBloc>(context).add(InitialPriority());
       BlocProvider.of<ImgBloc>(context).add(InitialImg());
    });
    return Scaffold(
        backgroundColor: Black(),
        appBar: MyAppBar(context),
        body: ListView(
          children: [
            const szdbx(ht: 40),
             AddImageEvent(img: ''),
            MyTextFieldForm(
                myController: titleControllerEvent, hintName: 'Title'),
            MyTextFieldForm(
                myController: contentControllerEvent, hintName: 'Content'),
            DateAndTime(),
            const szdbx(ht: 10),
            PriorityBtn(
                isSwitched: newPriority, onChangeMethod: onChangeFunction),
          ],
        ));
  }
}

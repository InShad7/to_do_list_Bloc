// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_do_it/controller/date/date_bloc.dart';
import 'package:just_do_it/controller/img/img_bloc.dart';
import 'package:just_do_it/controller/priority/priority_bloc.dart';
import 'package:just_do_it/function/db_event_function.dart';
// import 'package:just_do_it/function/db_function.dart';
import 'package:just_do_it/model/data_model.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/utilities/Colors.dart';
import 'package:just_do_it/utilities/textfieldForm.dart';
import 'package:just_do_it/widgets/priority.dart';
// import 'package:just_do_it/model/data_model_event.dart';
// import 'package:just_do_it/widgets/prioritySwitch.dart';
import 'package:just_do_it/widgets/sizedbox.dart';
// import 'package:intl/intl.dart';

String? myEventId;

 XFile? PickedFile;

class addEvent extends StatelessWidget {
  addEvent({Key? key}) : super(key: key);
   DateTime? dateTime;

  // late DateTime dateTime = DateTime.now();
  // String formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(dateTime);
  // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

  // String? imagePath;

  Future<void> TaskAddBtn() async {
    final _title = _titleController.text.trim();
    final _content = _contentController.text.trim();
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
      date: _dateTime,
      image: PickedFile!.path,
      priority: newPriority,
      id: _id,
      isCompleted: false,
    );
    addEvents(_events);
  }

  Widget img(context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<ImgBloc>(context).add(InitialImg());
    });
    return Padding(

        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<ImgBloc, ImgState>(
          builder: (context, state) {
            return Stack(
              children: [
                InkWell(
                  onTap: () => pickImage(context),
                  child: Container(
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ThemeGrey(),
                      image: DecorationImage(
                        image: state.imgPath ==''
                            ? AssetImage('assets/images/bg.jpg')
                                as ImageProvider
                            : FileImage(File(state.imgPath!)),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Icon(
                    Icons.photo_library_rounded,
                    size: 30,
                    color: Grey(),
                  ),

                  // pickImage(),
                )
              ],
            );
          },
        ));
  }

  Future<void> pickImage(context) async {
     PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      BlocProvider.of<ImgBloc>(context).add(AddImage());
      // setState(() {
      //   imagePath = PickedFile.path;
      // });
    }
  }

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
      initialDate: DateTime.now(),
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


  // bool mypriority = false;

  onChangeFunction(bool newValue, context) {
    newPriority = !newPriority;
    BlocProvider.of<PriorityBloc>(context).add(AddPriority());
    // setState(() {
    //   myPriority = newValue;
    // });
  }

  Row DateAndTime(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        date(context),
        time(context),
      ],
    );
  }

  AppBar MyAppBar(context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Black(),
        appBar: MyAppBar(context),
        body: ListView(
          children: [
            const szdbx(ht: 40),
            img(context),
            MyTextFieldForm(myController: _titleController, hintName: 'Title'),
            MyTextFieldForm(
                myController: _contentController, hintName: 'Content'),
            DateAndTime(context),
            const szdbx(ht: 10),
            PriorityBtn(
                isSwitched: newPriority, onChangeMethod: onChangeFunction),
          ],
        ));
  }
}

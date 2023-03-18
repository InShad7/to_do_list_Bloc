import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_do_it/controller/date/date_bloc.dart';
import 'package:just_do_it/controller/img/img_bloc.dart';
import 'package:just_do_it/controller/priority/priority_bloc.dart';
// import 'package:just_do_it/function/DB_Event_Function.dart';
import 'package:just_do_it/function/db_event_function.dart';
import 'package:just_do_it/model/data_model.dart';
import 'package:just_do_it/screens/Homescreen.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/screens/editTask.dart';
import 'package:just_do_it/utilities/textfieldForm.dart';
import 'package:just_do_it/widgets/addImage.dart';
import 'package:just_do_it/widgets/editDate.dart';
import 'package:just_do_it/widgets/editTime.dart';
import 'package:just_do_it/widgets/priority.dart';
import 'package:just_do_it/widgets/sizedbox.dart';

String? editImg;

class editEvent extends StatelessWidget {
  editEvent({Key? key, required this.passId, required this.passValue})
      : super(key: key);

  late Event passValue;
  final int passId;



  late final _titleController = TextEditingController(text: passValue.title);

  late final _contentController =
      TextEditingController(text: passValue.content);

  // String? imagePath;

  Future<void> TaskAddBtn(int index, context) async {
    final _title = _titleController.text.trim();
    final _content = _contentController.text.trim();
    final _dateTime = newDateTime;
    final _id = DateTime.now().toString();

    if (_title.isEmpty) {
      return;
    }
    print('$_title $_content $dateTime');

    final _events = Event(
        title: _title,
        content: _content,
        date: _dateTime == null ? DateTime.now() : newDateTime,
        image: pickedFile ==null ? editImg!:pickedFile!.path,
        priority: newPriority,
        id: _id,
        isCompleted: false);

  
    editEvents(passValue.id, context, _events);
    getEvent();
  }



  onChangeFunction(bool newValue, context) {
    newPriority = !newPriority;
    BlocProvider.of<PriorityBloc>(context).add(AddPriority());
    // setState(() {
    //   myPriority = newValue;
    // });
  }

  AppBar MyAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      actions: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  TaskAddBtn(passId, context);
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PriorityBloc>(context).add(EditPriority());
      BlocProvider.of<DateBloc>(context).add(EditDateTime());
      BlocProvider.of<ImgBloc>(context).add(EditImg());
    });
    dateTime = passValue.date;
    editPriority = passValue.priority;
    editImg = passValue.image;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: MyAppBar(context),
        body: ListView(
          children: [
            const szdbx(ht: 60),
            AddImageEvent(img: passValue.image),
            MyTextFieldForm(myController: _titleController, hintName: 'Title'),
            MyTextFieldForm(
                myController: _contentController, hintName: 'Content'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EditDate(passValue: passValue),
                EditTime(passValue: passValue),
                // date(),
                // time(),
              ],
            ),
            PriorityBtn(
                isSwitched: newPriority, onChangeMethod: onChangeFunction),
          ],
        ));
  }
}

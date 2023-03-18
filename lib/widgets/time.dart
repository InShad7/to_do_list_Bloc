import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_do_it/controller/date/date_bloc.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/utilities/colors.dart';

class selectTime extends StatelessWidget {
  const selectTime({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return BlocProvider.of<DateBloc>(context).add(Initial());
    });

    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

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
              dateTime = state.nDate!;
              final time = await pickTime(context);
              if (time == null) return;

              newDateTime = DateTime(dateTime.year, dateTime.month,
                  dateTime.day, time.hour, time.minute);

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
}

Future<TimeOfDay?> pickTime(context) => showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

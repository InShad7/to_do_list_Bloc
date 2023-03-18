import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_do_it/controller/date/date_bloc.dart';
import 'package:just_do_it/screens/addTask.dart';
import 'package:just_do_it/utilities/Colors.dart';

class selectDate extends StatelessWidget {
  // var date;

 const selectDate(
      {super.key,});

  @override
  Widget build(BuildContext context) {
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
              dateTime = state.nDate!;
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
              // date,
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
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2500));
}

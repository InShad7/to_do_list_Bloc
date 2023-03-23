import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_do_it/controller/chip/chip_bloc.dart';
import 'package:just_do_it/controller/search/search_bloc.dart';
// import 'package:just_do_it/controller/bloc/chip_bloc.dart';
// import 'package:just_do_it/controller/search/search_bloc.dart';
import 'package:just_do_it/screens/search.dart';
import 'package:just_do_it/widgets/searchFunction.dart';

// DateTimeRange? newDatePick;
// DateTimeRange(start: DateTime.now(), end: DateTime.now());

class FilterChips extends StatelessWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    DateTimeRange newDatePick;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(IsSelected());
      // BlocProvider.of<SearchBloc>(context).add(InitialVal2());
    });
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilterChip(
                label: const Text('High Priority'),
                backgroundColor: Color.fromARGB(255, 208, 119, 113),
                selected: (filter == 'high') ? true : false,
                onSelected: (bool val) {
                  // setState(() {
                  if (val) {
                    filter = 'high';
                    BlocProvider.of<SearchBloc>(context).add(IsSelected());
                    // priorityFilterHigh(val);
                    // searchTask(searchController.text, null, context);
                  } else {
                    filter = '';
                    BlocProvider.of<SearchBloc>(context).add(UnSelected());
                    // searchTask(searchController.text, null, context);
                  }
                  // },);
                },
              ),
              FilterChip(
                label: const Text('Low Priority'),
                backgroundColor: const Color.fromARGB(255, 206, 208, 113),
                selected: (filter == 'low') ? true : false,
                onSelected: (val) {
                  // setState(() {
                  if (val) {
                    filter = 'low';
                    BlocProvider.of<SearchBloc>(context)
                        .add(IsSelected()); // priorityFilterLow(val);
                    // searchTask(searchController.text, null, context);
                  } else {
                    filter = '';
                    BlocProvider.of<SearchBloc>(context).add(UnSelected());
                    // searchTask(searchController.text, null, context);
                  }
                  // });
                },
              ),
              FilterChip(
                label: const Text('Date '),
                backgroundColor: const Color.fromARGB(255, 113, 157, 208),
                selected: (filter == 'date') ? true : false,
                onSelected: (bool val) async {
                  // setState(() {
                  if (val) {
                    filter = 'date';

                    newDatePick = (await pickDateRange(context))!;
                    //  pickDateRange(context);
                    BlocProvider.of<SearchBloc>(context).add(IsSelected());
                    BlocProvider.of<SearchBloc>(context)
                        .add(NewDate(newDatePickBloc: newDatePick));
                    log(newDatePick.toString());

                    // searchTask(searchController.text, dateRange);
                  } else {
                    filter = '';
                    BlocProvider.of<SearchBloc>(context).add(UnSelected());
                    // searchTask(searchController.text, null, context);
                  }
                  // });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<DateTimeRange?> pickDateRange(context) async {
  return showDateRangePicker(
    context: context,
    initialDateRange: dateRange,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
}

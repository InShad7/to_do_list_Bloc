// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_do_it/controller/chip/chip_bloc.dart';
// import 'package:just_do_it/screens/search.dart';

// searchTask(String value, newDate,context) async {
//   // setState(
//   // () {
//   log(filter);
//   switch (filter) {
//     case 'high':
//       BlocProvider.of<ChipBloc>(context).add(IsSelected());
//       taskDisplay = taskList
//           .where(
//             (element) =>
//                 element.priority == true &&
//                 element.title.toLowerCase().contains(value),
//           )
//           .toList();

//       eventDisplay = eventList
//           .where((element) =>
//               element.priority == true &&
//               element.title.toLowerCase().contains(value))
//           .toList();

//       break;
//     case 'low':
//       taskDisplay = taskList
//           .where((element) =>
//               element.priority == false &&
//               element.title.toLowerCase().contains(value))
//           .toList();

//       eventDisplay = eventList
//           .where((element) =>
//               element.priority == false &&
//               element.title.toLowerCase().contains(value))
//           .toList();
//       break;
//     case 'date':
//       taskDisplay = taskList
//           .where((element) =>
//               element.title.toLowerCase().contains(value) &&
//               element.date.isAfter(DateTime(newDate.start.year,
//                   newDate.start.month, newDate.start.day)) &&
//               element.date.isBefore(DateTime(
//                   newDate.end.year, newDate.end.month, newDate.end.day + 1)))
//           .toList();

//       eventDisplay = eventList
//           .where((element) =>
//               element.date.isAfter(DateTime(newDate.start.year,
//                   newDate.start.month, newDate.start.day)) &&
//               element.date.isBefore(DateTime(
//                   newDate.end.year, newDate.end.month, newDate.end.day + 1)) &&
//               element.title.toLowerCase().contains(value))
//           .toList();
//       break;

//     default:
//       // }
//       taskDisplay = taskList
//           .where((element) =>
//               element.title.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//       eventDisplay = eventList
//           .where((element) =>
//               element.title.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//   }
//   // },
//   // );
//   // };
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_do_it/utilities/colors.dart';

import '../controller/priority/priority_bloc.dart';

class PriorityBtn extends StatelessWidget {
  const PriorityBtn({
    Key? key,
    required this.isSwitched,
    required this.onChangeMethod,
  }) : super(key: key);

  final bool isSwitched;
  final Function onChangeMethod;

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   return BlocProvider.of<PriorityBloc>(context).add(InitialPriority());
    // });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Priority',
          style: TextStyle(color: Grey(), fontSize: 18),
        ),
        Row(
          children: [
            Text(
              'Low',
              style: TextStyle(color: Grey()),
            ),
            BlocBuilder<PriorityBloc, PriorityState>(
              builder: (context, state) {
                return Switch(
                  value: state.priority,
                  onChanged: (newValue) {
                    onChangeMethod(newValue,context);
                  },
                  activeColor: SwitchActiveColor(),
                  inactiveThumbColor: SwitchInActiveColor(),
                  inactiveTrackColor: SwitchInActiveColor(),
                );
              },
            ),
            const Text(
              'High',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  //   bool myPriority = false;

  // onChangeFunction(bool newValue) {
  //   setState(() {
  //     myPriority = newValue;
  //   });
  // }
}

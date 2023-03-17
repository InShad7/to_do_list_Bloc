import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_do_it/model/data_model.dart';

ValueNotifier<List<Task>> taskNotifier = ValueNotifier([]);

Future<void> addTasks(Task value) async {
  final taskDB = await Hive.openBox<Task>('Task_db');
  final _id = await taskDB.add(value);
  // log(_id.toString());
  log(taskDB.values.toList().toString());
  // value.id = _id;

  taskNotifier.value.add(value);
  log(value.toString());
  log(value.title);
  log(value.date.toString());

  taskNotifier.notifyListeners();
}

Future<void> getTask() async {
  final taskDB = await Hive.openBox<Task>('Task_db');
  taskNotifier.value.clear();

  taskNotifier.value.addAll(taskDB.values);
  taskNotifier.notifyListeners();
}

// Future<void> deleteTask(int id) async {
//   final taskDB = await Hive.openBox<Task>('Task_db');
//   await taskDB.deleteAt(id);
//   getTask();

Future deleteTask(String index) async {
  final box = Hive.box<Task>("Task_db");

  final Map<dynamic, Task> taskListMap = box.toMap();
  dynamic desiredKey;
  taskListMap.forEach((key, value) {
    if (value.id == index) {
      desiredKey = key;
    }
  });
  await box.delete(desiredKey);
  getTask();
}
// }

editTasks(index, context, Task value) async {
  final taskDB = await Hive.openBox<Task>('task_db');
  final Map<dynamic, Task> taskMap = taskDB.toMap();
  dynamic desiredKey;
  taskMap.forEach((key, value) {
    if (value.id == index) {
      desiredKey = key;
    }
  });
  taskDB.put(desiredKey, value);
  getTask();
}

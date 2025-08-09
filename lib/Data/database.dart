import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class toDo_DB {
  // our box
  final _myBox = Hive.box('myBox');

  // List of tasks
  List toDo = [];

  // Run this method if the app is initiated for first time
  void createInitialData() {
    toDo = [
      ["Make Tutorial", false],
      ["Exercise", false],
    ];
  }

  // load data from DB
  void loadData() {
    toDo = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDo);
  }
}

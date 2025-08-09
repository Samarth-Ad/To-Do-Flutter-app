import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/database.dart';
import 'package:flutter_application_1/Util/dialogue_box.dart';
import 'package:flutter_application_1/Util/to_do_tile.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // list of To-Do Tasks
  toDo_DB toDo = toDo_DB();

  final _myBox = Hive.box('myBox');

  @override
  void initState() {
    // If app initiated for First time
    if (_myBox.get("TODOLIST") == null) {
      toDo.createInitialData();
    } else {
      toDo.loadData();
    }

    super.initState();
  }

  // Controller
  final _controller = TextEditingController();

  // checkbox function
  void CheckBoxChange(bool? value, int index) {
    setState(() {
      toDo.toDo[index][1] = !toDo.toDo[index][1];
    });
    toDo.updateDataBase();
  }

  // Creating new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogueBox(
          TaskNameController: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: SaveNewTask,
        );
      },
    );
  }

  // Saving a new task
  void SaveNewTask() {
    setState(() {
      toDo.toDo.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    _controller.clear();
    toDo.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      toDo.toDo.removeAt(index);
    });
    toDo.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 125),
          child: Text("To-Do App"),
        ),
        backgroundColor: Colors.amber,
      ),

      backgroundColor: Colors.amberAccent,

      body: ListView.builder(
        itemCount: toDo.toDo.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            TaskName: toDo.toDo[index][0],
            taskCompleted: toDo.toDo[index][1],
            MyOnChanged: (value) => CheckBoxChange(value, index),
            deleteTask: (context) => deleteTask(index),
          );
        },
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25, right: 25),
        child: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

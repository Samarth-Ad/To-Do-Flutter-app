import 'package:flutter/material.dart';
import 'package:flutter_application_1/Util/CButton.dart';

class DialogueBox extends StatelessWidget {
  DialogueBox({
    super.key,
    required this.TaskNameController,
    required this.onSave,
    required this.onCancel,
  });

  final TaskNameController;

  VoidCallback onSave, onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // User input field
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add new task",
              ),
              controller: TaskNameController,
            ),

            // Buttons to cancel and save
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyButton(name: "Save", onPressed: onSave),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyButton(name: "Cancel", onPressed: onCancel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

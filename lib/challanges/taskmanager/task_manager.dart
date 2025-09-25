import 'package:flutter/material.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  final List<String> tasks = ["Task 1", "Task 2", "Task 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),

      // For building a reorderable list
      body: ReorderableListView.builder(
        padding: const EdgeInsets.all(8.0),

        // Building each item in the list
        itemBuilder: (context, index) {
          return Padding(
            key: ValueKey(tasks[index]),
            padding: EdgeInsets.only(bottom: 8),

            // For swipe to delete
            child: Dismissible(
              key: ValueKey("dismissible-${tasks[index]}"),
              direction: DismissDirection.endToStart,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.delete, color: Colors.white),
              ),

              // Confirm before deleting
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (_) => DeleteDialogBox(),
                );
              },

              // Delete the item
              onDismissed: (direction) {
                setState(() {
                  tasks.removeAt(index);
                });
              },

              child: TaskCard(title: tasks[index]),
            ),
          );
        },
        itemCount: tasks.length,

        // for moving the item in the list up and down
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final item = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, item);
          });
        },

        // Remove shadow by wrapping with Material and setting elevation to 0
        proxyDecorator: (child, index, animation) {
          return Material(
            color: Colors.transparent,
            elevation: 0,
            type: MaterialType.transparency,
            child: child,
          );
        },
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  final String title;
  final bool isCompleted;

  const TaskCard({super.key, required this.title, this.isCompleted = false});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: ListTile(
        leading: Icon(Icons.menu),
        title: Text(
          widget.title,
          style: TextStyle(
            decoration: isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Icon(
          isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
          color: isCompleted ? Colors.green : Colors.grey,
        ),
        onTap: () {
          setState(() {
            isCompleted = !isCompleted;
          });
        },
      ),
    );
  }
}

class DeleteDialogBox extends StatelessWidget {
  const DeleteDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Task"),
      content: Text("Are you sure you want to delete this task?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Task deleted"),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
          child: Text("Delete"),
        ),
      ],
    );
  }
}

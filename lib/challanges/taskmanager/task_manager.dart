import 'package:flutter/material.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  final List<String> tasks = ["Task 1", "Task 2", "Task 3"];

  String? _lastRemovedTask;
  int? _lastRemovedIndex;

  void _deleteTask(int index) {
    setState(() {
      _lastRemovedTask = tasks[index];
      _lastRemovedIndex = index;
      tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Task deleted"),
        duration: const Duration(seconds: 3),

        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red.shade400,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: SnackBarAction(
          label: "Undo",
          textColor: Colors.white,
          onPressed: () {
            if (_lastRemovedTask != null && _lastRemovedIndex != null) {
              setState(() {
                tasks.insert(_lastRemovedIndex!, _lastRemovedTask!);
              });
            }
          },
        ),
      ),
    );
  }

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
      body: ReorderableListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            key: ValueKey(tasks[index]),
            padding: const EdgeInsets.only(bottom: 8),
            child: Dismissible(
              key: ValueKey("dismissible-${tasks[index]}"),
              direction: DismissDirection.endToStart,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                final confirm = await showDialog(
                  context: context,
                  builder: (_) => const DeleteDialogBox(),
                );
                if (confirm == true) {
                  _deleteTask(index);
                }
                return confirm;
              },
              child: TaskCard(title: tasks[index]),
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final item = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, item);
          });
        },
        proxyDecorator: (child, index, animation) {
          return Material(
            color: Colors.transparent,
            elevation: 0,
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
        leading: const Icon(Icons.menu),
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
      title: const Text("Delete Task"),
      content: const Text("Are you sure you want to delete this task?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Delete"),
        ),
      ],
    );
  }
}

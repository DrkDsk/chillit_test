import 'package:chillit_test/src/core/extensions/color_extension.dart';
import 'package:chillit_test/src/core/shared/ui/widgets/custom_card.dart';
import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_bloc.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_event.dart';
import 'package:chillit_test/src/features/tasks/ui/widgets/edit_task_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskGridView extends StatefulWidget {
  const TaskGridView({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  State<TaskGridView> createState() => _TaskGridViewState();
}

class _TaskGridViewState extends State<TaskGridView> {
  late final TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc = BlocProvider.of<TaskBloc>(context);
  }

  Future<void> _deleteTaskId({required String id}) async {
    _taskBloc.add(DeleteTaskEvent(id: id));
  }

  Future<void> _editTask(BuildContext context, Task task) async {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    String status = task.status;

    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar tarea'),
        content: EditTaskForm(
          onChangedDropDown: (value) => status = value,
          formKey: formKey,
          task: task,
          titleController: titleController,
          descriptionController: descriptionController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final newTask = task.copyWith(
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  status: status,
                );

                _taskBloc.add(EditTaskEvent(task: newTask));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tasks.isEmpty) {
      return const Center(child: Text('No hay tareas guardadas'));
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      itemCount: widget.tasks.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        final task = widget.tasks[index];

        return SingleChildScrollView(
          child: CustomCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: TextStyle(color: Colors.black.customOpacity(0.5)),
                  ),
                  Text(
                    task.status,
                    style: TextStyle(color: Colors.black.customOpacity(0.5)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        tooltip: 'Editar',
                        onPressed: () => _editTask(context, task),
                        icon: const Icon(Icons.edit, color: Colors.amber),
                      ),
                      IconButton(
                        color: Colors.redAccent,
                        onPressed: () => _deleteTaskId(id: task.id),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

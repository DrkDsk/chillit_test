import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_bloc.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_event.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_state.dart';
import 'package:chillit_test/src/features/tasks/ui/widgets/edit_task_form.dart';
import 'package:chillit_test/src/features/tasks/ui/widgets/task_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late final TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _taskBloc.add(const LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Task task = Task.initial();
          late final titleController = TextEditingController(text: "");
          late final descriptionController = TextEditingController(text: "");
          final formKey = GlobalKey<FormState>();
          String status = task.status;

          await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Agregar tarea'),
                content: EditTaskForm(
                  formKey: formKey,
                  onChangedDropDown: (value) => status = value,
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

                        _taskBloc.add(AddTaskEvent(task: newTask));
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            final status = state.status;

            if (status == TaskStateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (status == TaskStateStatus.error) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            if (status == TaskStateStatus.success) {
              return TaskGridView(tasks: state.tasks);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

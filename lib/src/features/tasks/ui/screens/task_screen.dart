import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_bloc.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_event.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_state.dart';
import 'package:chillit_test/src/features/tasks/ui/enum/task_dialog_model.dart';
import 'package:chillit_test/src/features/tasks/ui/widgets/task_dialog.dart';
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
          final Task initialTask = Task.initial();

          await showDialog(
            context: context,
            builder: (_) {
              return TaskDialog(
                mode: TaskDialogMode.create,
                initialTask: initialTask,
                onSubmit: (updatedTask) {
                  _taskBloc.add(AddTaskEvent(task: updatedTask));
                },
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

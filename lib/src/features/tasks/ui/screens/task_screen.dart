import 'package:chillit_test/src/features/tasks/ui/blocs/task_bloc.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_event.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_state.dart';
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

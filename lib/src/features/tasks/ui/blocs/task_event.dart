import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';

sealed class TaskEvent {
  const TaskEvent();
}

class LoadTasks extends TaskEvent {
  const LoadTasks();
}

class EditTaskEvent extends TaskEvent {
  final Task task;

  const EditTaskEvent({required this.task});
}

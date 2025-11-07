import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';

sealed class TaskEvent {
  const TaskEvent();
}

class LoadTasks extends TaskEvent {
  const LoadTasks();
}

class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent({required this.task});
}

class EditTaskEvent extends TaskEvent {
  final Task task;

  const EditTaskEvent({required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent({required this.id});
}

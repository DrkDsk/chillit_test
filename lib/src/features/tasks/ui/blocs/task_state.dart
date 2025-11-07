import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';

enum TaskStateStatus { initial, loading, success, error }

sealed class SideEffect {
  const SideEffect();
}

class TaskNavigationSideEffect extends SideEffect {
  const TaskNavigationSideEffect();
}

class TaskState {
  final TaskStateStatus status;
  final List<Task> tasks;
  final String? errorMessage;

  const TaskState({
    this.status = TaskStateStatus.loading,
    this.tasks = const [],
    this.errorMessage,
  });

  TaskState copyWith({
    TaskStateStatus? status,
    List<Task>? tasks,
    String? errorMessage,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage,
    );
  }
}

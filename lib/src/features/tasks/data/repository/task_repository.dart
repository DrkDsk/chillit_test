import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';

abstract interface class TaskRepository {
  Stream<List<Task>> getTasks();

  Future<bool> editTask({required Task task});
}

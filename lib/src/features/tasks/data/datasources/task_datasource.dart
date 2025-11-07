import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';

abstract interface class TaskDatasource {
  Stream<List<Task>> getTasks();

  Future<void> add({required Task task});

  Future<void> edit({required Task task});

  Future<void> delete({required String id});
}

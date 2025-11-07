import 'package:chillit_test/src/core/constants/firebase_constants.dart';
import 'package:chillit_test/src/features/tasks/data/repository/task_repository_impl.dart';
import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  group('TaskRepositoryImpl - getTasks', () {
    late FakeFirebaseFirestore fakeFirestore;
    late TaskRepositoryImpl repository;

    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();
      repository = TaskRepositoryImpl(firestore: fakeFirestore);
    });

    test('debe emitir una lista de tareas al escuchar el stream', () async {
      final collection = FirebaseConstants.taskCollection;

      await fakeFirestore.collection(collection).add({
        'title': 'Tarea 1',
        'description': 'Descripción 1',
        'status': 'Pendiente',
      });
      await fakeFirestore.collection(collection).add({
        'title': 'Tarea 2',
        'description': 'Descripción 2',
        'status': 'Hecho',
      });

      final stream = repository.getTasks();

      final tasks = await stream.first;

      expect(tasks, isA<List<Task>>());
      expect(tasks.length, 2);
      expect(tasks.first.title, 'Tarea 1');
      expect(tasks.last.status, 'Hecho');
    });

    test('debe emitir una lista vacía si no hay tareas', () async {
      final stream = repository.getTasks();
      final tasks = await stream.first;

      expect(tasks, isEmpty);
    });
  });
}

import 'package:chillit_test/src/features/tasks/data/repository/task_repository.dart';
import 'package:chillit_test/src/features/tasks/data/repository/task_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerRepositories() async {
  final firebaseFirestore = FirebaseFirestore.instance;

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(firestore: firebaseFirestore),
  );
}

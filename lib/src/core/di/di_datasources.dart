import 'package:chillit_test/src/features/login/data/data_sources/login_datasource.dart';
import 'package:chillit_test/src/features/login/data/data_sources/login_datasource_impl.dart';
import 'package:chillit_test/src/features/tasks/data/datasources/task_datasource.dart';
import 'package:chillit_test/src/features/tasks/data/datasources/task_datasource_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerDataSources() async {
  final firebaseFirestore = FirebaseFirestore.instance;

  getIt.registerLazySingleton<LoginDatasource>(() => LoginDatasourceImpl());

  getIt.registerLazySingleton<TaskDatasource>(
    () => TaskDatasourceImpl(firestore: firebaseFirestore),
  );
}

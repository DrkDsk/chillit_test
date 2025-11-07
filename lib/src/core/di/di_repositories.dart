import 'package:chillit_test/src/features/login/data/data_sources/login_datasource.dart';
import 'package:chillit_test/src/features/login/data/repositories/login_repository_impl.dart';
import 'package:chillit_test/src/features/login/domain/repositories/login_repository.dart';
import 'package:chillit_test/src/features/tasks/data/datasources/task_datasource.dart';
import 'package:chillit_test/src/features/tasks/data/repository/task_repository.dart';
import 'package:chillit_test/src/features/tasks/data/repository/task_repository_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerRepositories() async {
  final taskDataSource = getIt<TaskDatasource>();
  final loginDataSource = getIt<LoginDatasource>();

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(dataSource: taskDataSource),
  );

  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(datasource: loginDataSource),
  );
}

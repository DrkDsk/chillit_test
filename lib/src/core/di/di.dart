import 'package:chillit_test/src/core/di/di_bloc.dart';
import 'package:chillit_test/src/core/di/di_datasources.dart';
import 'package:chillit_test/src/core/di/di_repositories.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerDependencies() async {
  await registerDataSources();
  await registerRepositories();
  await registerBlocs();
}

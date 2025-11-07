import 'package:chillit_test/src/features/tasks/data/repository/task_repository.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerBlocs() async {
  final taskRepository = getIt<TaskRepository>();

  getIt.registerFactory<TaskBloc>(() => TaskBloc(repository: taskRepository));
}

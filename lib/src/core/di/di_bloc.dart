import 'package:chillit_test/src/features/login/domain/repositories/login_repository.dart';
import 'package:chillit_test/src/features/login/ui/cubits/login_cubit.dart';
import 'package:chillit_test/src/features/tasks/data/repository/task_repository.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerBlocs() async {
  final taskRepository = getIt<TaskRepository>();
  final loginRepository = getIt<LoginRepository>();

  getIt.registerFactory<TaskBloc>(() => TaskBloc(repository: taskRepository));
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(repository: loginRepository),
  );
}

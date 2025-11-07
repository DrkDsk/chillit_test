import 'package:bloc/bloc.dart';
import 'package:chillit_test/src/features/tasks/data/repository/task_repository.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_event.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _repository;

  TaskBloc({required TaskRepository repository})
    : _repository = repository,
      super(TaskState()) {
    on<LoadTasks>(_loadTask);
    on<EditTaskEvent>(_editTask);
  }

  Future<void> _loadTask(LoadTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: TaskStateStatus.loading, errorMessage: null));

    try {
      await emit.forEach(
        _repository.getTasks(),
        onData: (tasks) {
          return state.copyWith(status: TaskStateStatus.success, tasks: tasks);
        },
        onError: (_, __) {
          return state.copyWith(
            status: TaskStateStatus.error,
            errorMessage: 'Error al obtener las tareas',
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TaskStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _editTask(EditTaskEvent event, Emitter<TaskState> emit) async {
    final task = event.task;

    emit(state.copyWith(status: TaskStateStatus.loading, errorMessage: null));

    try {
      final result = await _repository.editTask(task: task);

      if (!result) {
        state.copyWith(
          status: TaskStateStatus.error,
          errorMessage: "Ha ocurrido un error al editar",
        );
        return;
      }

      state.copyWith(status: TaskStateStatus.success);
    } catch (e) {
      emit(
        state.copyWith(
          status: TaskStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

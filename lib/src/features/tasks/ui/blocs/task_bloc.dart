import 'dart:async';

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
    on<AddTaskEvent>(_addTaskEvent);
    on<EditTaskEvent>(_editTask);
    on<DeleteTaskEvent>(_deleteTask);
  }

  Future<void> _addTaskEvent(
    AddTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final task = event.task;

    emit(state.copyWith(status: TaskStateStatus.loading, errorMessage: null));

    try {
      await _repository.add(task: task);

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

  Future<void> _deleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final taskId = event.id;

    emit(state.copyWith(status: TaskStateStatus.loading, errorMessage: null));

    try {
      await _repository.delete(id: taskId);

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
      await _repository.edit(task: task);

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

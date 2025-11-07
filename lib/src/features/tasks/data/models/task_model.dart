import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory TaskModel.fromFirestore(Map<String, dynamic> data, String id) {
    return TaskModel(
      id: id,
      title: data['title'] ?? '',
      status: data['completed'] ?? 'Pendiente',
      description: data['description'] ?? '',
    );
  }

  Task toEntity() {
    return Task(id: id, title: title, description: description, status: status);
  }
}

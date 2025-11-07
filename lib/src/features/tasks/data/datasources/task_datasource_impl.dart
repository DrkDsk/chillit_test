import 'package:chillit_test/src/core/constants/firebase_constants.dart';
import 'package:chillit_test/src/features/tasks/data/datasources/task_datasource.dart';
import 'package:chillit_test/src/features/tasks/data/models/task_model.dart';
import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDatasourceImpl implements TaskDatasource {
  final FirebaseFirestore _firestore;

  const TaskDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<void> add({required Task task}) async {
    final tasksRef = FirebaseFirestore.instance.collection(
      FirebaseConstants.taskCollection,
    );

    await tasksRef.add({
      'title': task.title,
      'description': task.description,
      'status': task.status,
    });

    return;
  }

  @override
  Future<void> delete({required String id}) async {
    await FirebaseFirestore.instance
        .collection(FirebaseConstants.taskCollection)
        .doc(id)
        .delete();

    return;
  }

  @override
  Future<void> edit({required Task task}) async {
    final title = task.title;
    final description = task.description;
    final status = task.status;

    await FirebaseFirestore.instance
        .collection(FirebaseConstants.taskCollection)
        .doc(task.id)
        .update({'title': title, 'description': description, 'status': status});

    return;
  }

  @override
  Stream<List<Task>> getTasks() {
    final taskModels = _firestore
        .collection(FirebaseConstants.taskCollection)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TaskModel.fromFirestore(doc.data(), doc.id).toEntity();
          }).toList();
        });

    return taskModels;
  }
}

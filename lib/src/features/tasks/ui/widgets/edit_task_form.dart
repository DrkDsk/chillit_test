import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';
import 'package:flutter/material.dart';

class EditTaskForm extends StatelessWidget {
  const EditTaskForm({super.key,
  required this.task, required,
  required this.titleController,
  required this.descriptionController,
  required this.formKey,});

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Task task;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    String status = task.status;

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Título'),
            validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Descripción'),
            validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
          ),
          DropdownButtonFormField<String>(
            initialValue: status,
            decoration: const InputDecoration(labelText: 'Estado'),
            items: const [
              DropdownMenuItem(value: 'Pendiente', child: Text('Pendiente')),
              DropdownMenuItem(value: 'En Proceso', child: Text('En Proceso')),
              DropdownMenuItem(value: 'Hecho', child: Text('Hecho')),
            ],
            onChanged: (val) => status = val ?? 'Pendiente',
          ),
        ],
      ),
    );
  }
}

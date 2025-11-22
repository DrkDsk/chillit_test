import 'package:flutter/material.dart';

class TaskForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String initialStatus;
  final ValueChanged<String?> onStatusChanged;

  const TaskForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.initialStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Título'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Campo requerido' : null,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Descripción'),
            maxLines: 3,
          ),
          DropdownButtonFormField<String>(
            initialValue: initialStatus,
            decoration: const InputDecoration(labelText: 'Estado'),
            items: const [
              DropdownMenuItem(value: 'Pendiente', child: Text('Pendiente')),
              DropdownMenuItem(value: 'En Proceso', child: Text('En Proceso')),
              DropdownMenuItem(value: 'Hecho', child: Text('Hecho')),
            ],
            onChanged: onStatusChanged,
          ),
        ],
      ),
    );
    return const Placeholder();
  }
}

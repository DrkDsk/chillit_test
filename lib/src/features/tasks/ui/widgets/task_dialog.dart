import 'package:chillit_test/src/features/tasks/domain/entities/task.dart';
import 'package:chillit_test/src/features/tasks/ui/enum/task_dialog_model.dart';
import 'package:chillit_test/src/features/tasks/ui/widgets/task_form.dart';
import 'package:flutter/material.dart';

class TaskDialog extends StatelessWidget {
  final TaskDialogMode mode;
  final Task initialTask;
  final void Function(Task updatedTask) onSubmit;

  const TaskDialog({
    super.key,
    required this.mode,
    required this.initialTask,
    required this.onSubmit,
  });

  String get _title =>
      mode == TaskDialogMode.create ? 'Agregar tarea' : 'Editar tarea';

  String get _submitLabel =>
      mode == TaskDialogMode.create ? 'Guardar' : 'Actualizar';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: initialTask.title);
    final descriptionController = TextEditingController(
      text: initialTask.description,
    );
    String status = initialTask.status;

    return AlertDialog(
      title: Text(_title),
      content: TaskForm(
        formKey: formKey,
        titleController: titleController,
        descriptionController: descriptionController,
        initialStatus: status,
        onStatusChanged: (value) => status = value!,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final updatedTask = initialTask.copyWith(
                title: titleController.text.trim(),
                description: descriptionController.text.trim(),
                status: status,
              );

              onSubmit(updatedTask);
              Navigator.pop(context);
            }
          },
          child: Text(_submitLabel),
        ),
      ],
    );
  }
}

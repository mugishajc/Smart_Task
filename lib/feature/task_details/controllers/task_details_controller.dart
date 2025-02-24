import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/core/dependency/repository.dart';
import 'package:smart_task/data/repository/task/task_repository.dart';
import '../../../core/logger.dart';
import '../../../data/model/todo.dart';

final taskDetailsProvider = StateProvider<Todo>((ref) => Todo());

final taskDetailsViewControllerProvider = Provider((ref) => _TaskDetailsController(ref: ref));

class _TaskDetailsController {
  final Ref ref;
  late TaskRepository _repository;

  _TaskDetailsController({required this.ref}) {
    _repository = ref.watch(Repository.task);
  }

  Future<void> updateTask(uid,
      {String? title,
        String? description,
        String? dateTime,
        String? priority}) async {
    try {
      _repository.updateTask(
        uid,
        title: title ?? '',
        description: description ?? '',
        dateTime: dateTime ?? '',
        priority: priority ?? '',
      );
    } catch (error, stackTrace) {
      Log.error('Error updating task: ${error.runtimeType}: $error');
      Log.error(stackTrace.toString());
    }
  }

  void updateSubTask() => _repository.updateSubTask();

  void completeTask(uid) => _repository.completeTask(uid);

  void undoCompleteTask(uid) => _repository.undoCompleteTask(uid);

  void removeTodo(uid) => _repository.removeTodo(uid);

  void addSubTask() {
    final currentState = ref.read(taskDetailsProvider);
    final updatedSubTasks = List<SubTask>.from(currentState.subTask)..add(SubTask());
    ref.read(taskDetailsProvider.notifier).update((state) => state.copyWith(subTask: updatedSubTasks));
  }
}
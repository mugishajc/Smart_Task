import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

import '../../../constant/shared_preference_key.dart';
import '../../../feature/task_details/controllers/task_details_controller.dart';
import '../../model/todo.dart';
import '../../../core/logger.dart';

final _taskRepoProvider = Provider((ref) => TaskRepository(ref: ref));

class TaskRepository {
  TaskRepository({required this.ref});

  final Ref ref;

  static Provider<TaskRepository> get provider => _taskRepoProvider;

  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');

  CollectionReference get userTasksCollection {
    Log.info("User UID: ${getStringAsync(USER_UID)}");
    return tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
  }

  Stream<List<Todo>> pendingTasks() {
    Query userTasksQuery = userTasksCollection
        .where("isCompleted", isEqualTo: false)
        .orderBy("dateTime", descending: true);
    return userTasksQuery.snapshots().map(parseSnapshot);
  }

  Stream<List<Todo>> completedTasks() {
    Query userTasksQuery = userTasksCollection
        .where("isCompleted", isEqualTo: true)
        .orderBy("dateTime", descending: true);
    return userTasksQuery.snapshots().map(parseSnapshot);
  }

  Future<void> createNewTask(String title, description, dateTime, priority) async {
    try {
      DocumentReference documentReferencer = userTasksCollection.doc();
      await documentReferencer.set({
        "title": title,
        "description": description,
        "dateTime": dateTime != ""
            ? DateFormat('hh:mm aa MMM dd,yyyy').parse(dateTime).millisecondsSinceEpoch
            : DateTime.now().millisecondsSinceEpoch,
        "priority": priority == "" ? "Low" : priority,
        "subTask": [],
        "isCompleted": false,
      });
    } catch (e, stackTrace) {
      Log.error("Error creating task: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }

  Future<void> updateTask(String uid, {String? title, String? description, String? dateTime, String? priority}) async {
    try {
      Map<String, dynamic> updateData = {};
      if (title != null) updateData["title"] = title;
      if (description != null) updateData["description"] = description;
      if (dateTime != null) {
        DateTime? parsedDateTime = DateFormat('hh:mm aa MMM dd,yyyy').tryParse(dateTime);
        if (parsedDateTime != null) {
          updateData["dateTime"] = parsedDateTime.millisecondsSinceEpoch;
        }
      }
      if (priority != null) updateData["priority"] = priority;
      if (updateData.isNotEmpty) {
        await userTasksCollection.doc(uid).update(updateData);
      }
    } catch (e, stackTrace) {
      Log.error("Error updating task: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }

  Future<void> updateSubTask() async {
    try {
      List<Map<String, dynamic>> subTaskMappedList = ref.read(taskDetailsProvider).subTask.map((subTask) => subTask.toMap()).toList();
      await userTasksCollection.doc(ref.read(taskDetailsProvider).uid).update({"subTask": subTaskMappedList});
    } catch (e, stackTrace) {
      Log.error("Error updating subtasks: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }

  Future<void> completeTask(String uid) async {
    try {
      await userTasksCollection.doc(uid).update({"isCompleted": true});
    } catch (e, stackTrace) {
      Log.error("Error completing task: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }

  Future<void> undoCompleteTask(String uid) async {
    try {
      await userTasksCollection.doc(uid).update({"isCompleted": false});
    } catch (e, stackTrace) {
      Log.error("Error undoing complete task: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }

  Future<void> removeTodo(String uid) async {
    try {
      await userTasksCollection.doc(uid).delete();
    } catch (e, stackTrace) {
      Log.error("Error removing task: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }
}
// todo.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Todo {
  final String title;
  final String description;
  final String dateTime;
  final List<SubTask> subTask;
  final String priority;
  final bool isCompleted;
  final String uid;

  Todo({
    this.title = "",
    this.description = "",
    this.dateTime = "",
    this.subTask = const [],
    this.priority = "",
    this.isCompleted = false,
    this.uid = "",
  });

  Todo copyWith({
    String? title,
    String? description,
    String? dateTime,
    List<SubTask>? subTask,
    String? priority,
    bool? isCompleted,
    String? uid,
  }) =>
      Todo(
        title: title ?? this.title,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        subTask: subTask ?? this.subTask,
        priority: priority ?? this.priority,
        isCompleted: isCompleted ?? this.isCompleted,
        uid: uid ?? this.uid,
      );

  factory Todo.fromJson(Map<String, dynamic> json) {
    final dateTimeMillis = json["dateTime"];
    final dateTimeString = dateTimeMillis != null
        ? DateFormat("MMM dd,yyyy hh:mm aa")
        .format(DateTime.fromMillisecondsSinceEpoch(dateTimeMillis))
        : "";

    return Todo(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      dateTime: dateTimeString,
      subTask: (json["subTask"] as List<dynamic>?)
          ?.map((task) => SubTask.fromJson(task))
          .toList() ??
          [],
      priority: json["priority"] ?? "",
      isCompleted: json["isCompleted"] ?? false,
      uid: json["id"] ?? "",
    );
  }

  Todo.fromMap(Map<String, dynamic> map, String id)
      : title = map["title"] ?? "",
        description = map["description"] ?? "",
        dateTime = map["dateTime"] != null
            ? DateFormat("MMM dd,yyyy hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(map["dateTime"]))
            : "",
        subTask = (map["subTask"] as List<dynamic>?)
            ?.map((e) => SubTask.fromMap(e))
            .toList() ??
            [],
        priority = map["priority"] ?? "",
        isCompleted = map["isCompleted"] ?? false,
        uid = id;
}

class SubTask {
  String title;
  bool isCompleted;

  SubTask({
    this.title = "",
    this.isCompleted = false,
  });

  factory SubTask.fromJson(Map<String, dynamic> json) => SubTask(
    title: json["title"] ?? "",
    isCompleted: json["isCompleted"] ?? false,
  );

  Map<String, dynamic> toMap() => {
    "title": this.title,
    "isCompleted": this.isCompleted,
  };

  SubTask.fromMap(Map<String, dynamic> map)
      : title = map["title"] ?? "",
        isCompleted = map["isCompleted"] ?? false;

  SubTask copyWith({String? title, bool? isCompleted}) {
    return SubTask(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

List<Todo> parseSnapshot(QuerySnapshot snapshot) => snapshot.docs.map((e) {
  return Todo.fromMap(e.data() as Map<String, dynamic>, e.id);
}).toList();
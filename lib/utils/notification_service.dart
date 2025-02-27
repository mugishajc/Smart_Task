import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'assets.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings(InkomokoSmartTaskAssets.google);
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'Inkomoko_smart_task_completed_channel',
    'Task Completed Notifications',
    channelDescription: 'Notifications when a task is completed',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
  );
}
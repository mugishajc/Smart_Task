import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/feature/startup/views/splash_screen.dart';
import 'package:smart_task/utils/notification_service.dart';
import 'package:nb_utils/nb_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    // await FirebaseFirestore.instance.collection('test').add({"test": "success"}); // TODO Remove this
    await initialize();
  } catch (e) {
    print("Error during initialization: $e");
  }
  await initNotifications();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Task',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: SplashScreen(),
    );
  }
}

extension Navigation on Widget {
  Future<T?> push<T extends Object?>(BuildContext context) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (context) => this),
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(BuildContext context) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (context) => this),
      (route) => false,
    );
  }

  Future<dynamic> pushReplacement<T extends Object?>(BuildContext context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => this),
    );
  }

  void pop<T extends Object?>(BuildContext context, [T? result]) {
    if (Navigator.canPop(context)) {
      Navigator.pop<T>(context, result);
    }
  }
}

// Ensure themeData is correct (from your previous theme.dart)
// Example (replace with your actual themeData):
ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
    background: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.white,
    elevation: 0,
  ),
);

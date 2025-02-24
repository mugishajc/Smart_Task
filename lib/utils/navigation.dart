import 'package:flutter/material.dart';

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
    return Navigator.pushReplacement( // Removed <T>
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
import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback? action; // Made nullable
  Timer? _timer; // Explicit type

  Debouncer({this.milliseconds = 500});

  run(VoidCallback action) {
    this.action = action; // Assign action to the class variable
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      if(this.action != null){
        this.action!();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    action = null;
  }
}
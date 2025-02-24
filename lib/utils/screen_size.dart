import 'package:flutter/material.dart';

class InkomokoSmartTaskSize {
  static Size size(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

  static double width(BuildContext context, double width) {
    double _width = (width / 720) * (size(context).width > 700 ? 700 : size(context).width);
    return _width;
  }

  static double height(BuildContext context, double height) {
    double _height = (height / 1600) * (size(context).height > 1080 ? 1080 : size(context).height);
    return _height;
  }
}
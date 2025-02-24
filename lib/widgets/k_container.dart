import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class KContainer extends LeafRenderObjectWidget {
  KContainer({
    Key? key,
    required this.width,
    required this.height,
    this.color = Colors.transparent,
  }) : super(key: key);

  final double width;
  final double height;
  final Color color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderKContainer(
      width: width,
      height: height,
      color: color,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderKContainer renderObject) {
    renderObject
      ..width = width
      ..height = height
      ..color = color;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));
    properties.add(ColorProperty('color', color));
  }
}

class RenderKContainer extends RenderBox {
  RenderKContainer({
    required double width,
    required double height,
    required Color color,
  })  : _width = width,
        _height = height,
        _color = color;

  double _width;
  double _height;
  Color _color;

  double get width => _width;
  double get height => _height;
  Color get color => _color;

  set width(double value) {
    if (_width == value) return;
    _width = value;
    markNeedsLayout();
  }

  set height(double value) {
    if (_height == value) return;
    _height = value;
    markNeedsLayout();
  }

  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = width;
    final desiredHeight = height;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (size > Size.zero) {
      context.canvas.drawRect(offset & size, Paint()..color = color);
    }
  }
}
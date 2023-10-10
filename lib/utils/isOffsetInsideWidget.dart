import 'package:flutter/cupertino.dart';

bool isOffsetInsideWidget(GlobalKey key, Offset offset) {
  final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox != null) {
    final Size size = renderBox.size;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Rect rect = Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
    return rect.contains(offset);
  }
  return false;
}
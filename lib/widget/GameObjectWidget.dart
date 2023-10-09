import 'package:flutter/material.dart';

import '../GameObject.dart';

class GameObjectWidget extends StatelessWidget {
  final GameObject object;

  GameObjectWidget(this.object);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      color: _getObjectColor(object.type),
      alignment: Alignment.center,
      child: Text(
        object.getDisplayName(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getObjectColor(ObjectType type) {
    switch (type) {
      case ObjectType.Rock:
        return Colors.red;
      case ObjectType.Paper:
        return Colors.blue;
      case ObjectType.Scissors:
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}
import 'package:flutter/material.dart';
import '../utils/game_object.dart';

class GameObjectWidget extends StatelessWidget {
  final GameObject object;

  GameObjectWidget(this.object);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child:  _getImageForType(object.type));
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

  Image _getImageForType(ObjectType type) {
    switch (type) {
      case ObjectType.Rock:
        return  Image.asset("assets/rock_btn.png",width: 35,);
      case ObjectType.Paper:
        return  Image.asset("assets/paper_btn.png",width: 35,);
      case ObjectType.Scissors:
        return  Image.asset("assets/scisor_btn.png",width: 35,);
      default:
        return  Image.asset("assets/scisor_btn.png",width: 35,);
    }
  }
}
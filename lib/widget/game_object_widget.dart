import 'package:flutter/material.dart';
import '../utils/game_object.dart';

class GameObjectWidget extends StatelessWidget {
  final GameObject object;

  const GameObjectWidget(this.object, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child:  _getImageForType(object.type));
  }
  Image _getImageForType(ObjectType type) {
    switch (type) {
      case ObjectType.Rock:
        return  Image.asset("assets/rock_btn.png",width: 35,);
      case ObjectType.Paper:
        return  Image.asset("assets/paper_btn.png",width: 35,);
      case ObjectType.Scissors:
        return  Image.asset("assets/scissor_btn.png",width: 35,);
      default:
        return  Image.asset("assets/scissor_btn.png",width: 35,);
    }
  }
}
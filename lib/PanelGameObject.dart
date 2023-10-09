import 'dart:math';
import 'package:rock_paper_scissors_game/GameObject.dart';

class GameItem {

  final ObjectType type;
  double x;
  double y;
  double dx;
  double dy;

  GameItem({required this.type, required this.x, required this.y})
      : dx = Random().nextDouble() * 2 - 1,
        dy = Random().nextDouble() * 2 - 1;
}

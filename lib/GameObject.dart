import 'dart:math';

enum ObjectType { Rock, Paper, Scissors }

class GameObject {
  ObjectType type;
  double x;
  double y;
  double dx;
  double dy;

  GameObject({
    required this.type,
    required this.x,
    required this.y,
  }) : dx = Random().nextDouble() * 2 - 1,
        dy = Random().nextDouble() * 2 - 1;

  String getDisplayName() {
    switch (type) {
      case ObjectType.Rock:
        return 'R';
      case ObjectType.Paper:
        return 'P';
      case ObjectType.Scissors:
        return 'S';
      default:
        return '';
    }
  }
}

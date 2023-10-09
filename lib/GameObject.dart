enum ObjectType { Rock, Paper, Scissors }

class GameObject {
  ObjectType type;

  GameObject(this.type);

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

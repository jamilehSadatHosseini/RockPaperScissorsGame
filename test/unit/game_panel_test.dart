import 'package:rock_paper_scissors_game/screen/game_panel.dart';
import 'package:test/test.dart';
import 'package:rock_paper_scissors_game/utils/game_object.dart';

void main() {
  group('handleCollision', () {
    final gamePanelState = GamePanelState();

    test('when two object with same type hit eachother', () {
      final obje1 = GameObject(type: ObjectType.Rock, x: 1, y: 1);
      final obje2 = GameObject(type: ObjectType.Rock, x: -1, y: -1);
      // Store initial dx and dy values
      final initialDx1 = obje1.dx;
      final initialDy1 = obje1.dy;
      final initialDx2 = obje2.dx;
      final initialDy2 = obje2.dy;
      gamePanelState.handleCollision(obje1, obje2);
      expect(obje1.dx, initialDx2);
      expect(obje1.dy, initialDy2);
      expect(obje2.dx, initialDx1);
      expect(obje2.dy, initialDy1);
    });
    test('when a Rock object hit a paperObject', () {
      final rock = GameObject(type: ObjectType.Rock, x: 1, y: 1);
      final paper = GameObject(type: ObjectType.Paper, x: -1, y: -1);
      final removeObject = gamePanelState.handleCollision(rock, paper);
      expect(removeObject, contains(rock));
    });
    test('when a Rock object hit a Scissor Object', () {
      final rock = GameObject(type: ObjectType.Rock, x: 1, y: 1);
      final scissor = GameObject(type: ObjectType.Scissors, x: -1, y: -1);
      final removeObject = gamePanelState.handleCollision(rock, scissor);
      expect(removeObject, contains(scissor));
    });
    test('when a paperObject hit a Scissor Object', (){
      final paper = GameObject(type: ObjectType.Paper, x: 1, y: 1);
      final scissor = GameObject(type: ObjectType.Scissors, x: -1, y: -1);
      final removeObject = gamePanelState.handleCollision(paper, scissor);
      expect(removeObject, contains(paper));
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_paper_scissors_game/main.dart';
import 'package:rock_paper_scissors_game/utils/game_object.dart';
import 'package:rock_paper_scissors_game/widget/game_object_widget.dart';

void main() {
  testWidgets(
      'game object return  correct icon for paper, rock and scissor',
          (widgetTester) async {
        // Create a test GameObject
        final gameObject = GameObject(type: ObjectType.Rock, x: 0, y: 0);
        await widgetTester.pumpWidget(
            MaterialApp(
              home: GameObjectWidget(gameObject),
            ));
        // Verify that the correct image is displayed based on the GameObject's type

        expect(find.byWidgetPredicate((widget) {
          if (widget is Image) {
            return widget.image == const AssetImage("assets/rock_btn.png");
          }
          return false;
        }), findsOneWidget);
          });
}
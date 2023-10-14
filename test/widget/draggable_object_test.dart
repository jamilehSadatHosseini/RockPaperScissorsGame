import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_paper_scissors_game/utils/game_object.dart';
import 'package:rock_paper_scissors_game/widget/draggable_object.dart';

void main() {
  group('draggableObjectTest', () {
    testWidgets(
        'the draggable object behaves when drag and drop as expected',
            (WidgetTester tester) async {
          // Create a GlobalKey for the target container.
          final targetKey = GlobalKey();

          // Create a GameObject instance.
          final gameObject = GameObject(type: ObjectType.Rock, x: 0, y: 0);

          // Variable to check if onDrop callback is called.
          bool isDroppedCalled = false;

          // Build the MaterialApp with a Column containing DraggableObject and a target container.
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    DraggableObject(
                      object: gameObject,
                      onDrop: (obj) => isDroppedCalled = true,
                      expandedContainerKey: targetKey,
                    ),
                    // A target container to drop the DraggableObject into.
                    Container(
                      key: targetKey,
                      width: 500,
                      height: 500,
                      color: Colors.red, // Color it red for visibility.
                    ),
                  ],
                ),
              ),
            ),
          );

          // Find the DraggableObject.
          final draggable = find.byType(DraggableObject);
          expect(draggable, findsOneWidget);

          // Obtain the offset of the center of the target container.
          final targetCenter = tester.getCenter(find.byKey(targetKey));

          // Calculate the drag offset to ensure the DraggableObject is dragged into the target container.
          final dragOffset = targetCenter - tester.getTopLeft(draggable) + const Offset(0, 50);  // Adjusting the offset.

          // Drag the DraggableObject to the center of the target container.
          await tester.drag(draggable, dragOffset);
          await tester.pumpAndSettle();

          // Check if the onDrop callback was called.
          expect(isDroppedCalled, isTrue);
        });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_paper_scissors_game/utils/game_object.dart';
import 'package:rock_paper_scissors_game/widget/draggable_object.dart';
import 'package:rock_paper_scissors_game/widget/row_container.dart';

void main() {
  group('RowConainerWidget', () {
  testWidgets("is the count of items correct", (widgetTester) async {
    final rowContainer = RowContainer(
        objectType: ObjectType.Rock,
        itemCount: 5,
        onDrop: (GameObject object) {},
        expandedContainerKey: GlobalKey());
    await widgetTester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: rowContainer,
      ),
    ));
    expect(find.byType(DraggableObject), findsNWidgets(5));
  });

  testWidgets('remove and item droped', (widgetTester) async {
    final key=GlobalKey();
    final rowContainer = RowContainer(
        objectType: ObjectType.Rock,
        itemCount: 5,
        onDrop: (GameObject object) {},
        expandedContainerKey: key);
    await widgetTester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(width: 200,height: 200,key: key,
            child:rowContainer ,),
            ],
        ),
      ),
    ));
    await widgetTester.pumpAndSettle();

    final firstDraggable = find.byType(DraggableObject).first;
    expect(firstDraggable, findsOneWidget);

    // Drag the first DraggableObject to the center of the container
    await widgetTester.drag(firstDraggable, const Offset(100,100));
    await widgetTester.pumpAndSettle();
    expect(find.byType(DraggableObject), findsNWidgets(4));
  });
  });
}

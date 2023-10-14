import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_paper_scissors_game/utils/isOffsetInsideWidget.dart';

void main() {
  testWidgets(
      "isOffsetInsideWidget should determine if an offset is inside a widget",
      (WidgetTester tester) async {
    //Create a key for the widget we want to test
    final myKey = GlobalKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            key: myKey,
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    ));

    //Scenario1: offset is inside the widget
    final insideOffset = tester.getCenter(find.byKey(myKey));
    expect(isOffsetInsideWidget(myKey, insideOffset), true);
    //Scenario2
    const outsideOffset = Offset(150, 150);
    expect(isOffsetInsideWidget(myKey, outsideOffset), false);

    //Scenario3
    final inavlidKey = GlobalKey();
    expect(isOffsetInsideWidget(inavlidKey, insideOffset), false);
  });
}

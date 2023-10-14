import 'package:flutter/material.dart';

import '../utils/game_object.dart';
import '../widget/row_container.dart';
import 'game_panel.dart';
class GameHandler {
  List<GameObject> droppedObjects = [];

  void handleDrop(GameObject droppedObject) {
    droppedObjects.add(droppedObject);
  }
}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<GameObject> droppedObjects = [];

  void handleDrop(GameObject droppedObject) {
    setState(() {
      droppedObjects.add(droppedObject);
    });
  }

  @override
  Widget build(BuildContext context) {
    final expandedContainerKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              key: expandedContainerKey,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              margin: const EdgeInsets.all(10),
              child: GamePanel(droppedObjects: droppedObjects),
            ),
          ),
          RowContainer(
              objectType: ObjectType.Rock,
              itemCount: 5,
              onDrop: handleDrop,
              expandedContainerKey: expandedContainerKey),
          RowContainer(
            objectType: ObjectType.Paper,
            itemCount: 5,
            onDrop: handleDrop,
            expandedContainerKey: expandedContainerKey,
          ),
          RowContainer(
              objectType: ObjectType.Scissors,
              itemCount: 5,
              onDrop: handleDrop,
              expandedContainerKey: expandedContainerKey),
        ],
      ),
    );
  }
}

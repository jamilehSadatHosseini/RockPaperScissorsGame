import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../GameObject.dart';
import '../widget/RowContainer.dart';
import 'GamePanel.dart';

class MainScreen extends StatefulWidget {
  final GlobalKey<GamePanelState> gamePanelKey = GlobalKey<GamePanelState>();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<GameObject> droppedObjects = []; // Track dropped objects here
  int RCoount = 5;
  int Pcount = 5;
  int SCount = 5;

  // Define the handleDrop method here
  void handleDrop(GameObject droppedObject) {
    setState(() {
      switch (droppedObject.type) {
        case ObjectType.Rock:
          RCoount = RCoount > 0 ? (RCoount - 1) : 0;
          break;
        case ObjectType.Paper:
          Pcount = Pcount > 0 ? (Pcount - 1) : 0;
          break;
        case ObjectType.Scissors:
          SCount = SCount > 0 ? (SCount - 1) : 0;
          break;
      }
      if (droppedObjects.length < 3) {
        droppedObjects.add(droppedObject);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Column(
        children: [

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              margin: const EdgeInsets.all(10),
              child: GamePanel(
                droppedObjects:
                    droppedObjects,gamePanelKey: widget.gamePanelKey,
              ),
            ),
          ),
          RowContainer(
            objectType: ObjectType.Rock,
            itemCount: RCoount,
            onDrop: handleDrop,
            getGamePanelRenderBox: widget.gamePanelKey.currentState!.getGamePanelRenderBox,

          ),
          RowContainer(
            objectType: ObjectType.Paper,
            itemCount: Pcount,
            onDrop: handleDrop,
            getGamePanelRenderBox: widget.gamePanelKey.currentState!.getGamePanelRenderBox,

          ),
          RowContainer(
            objectType: ObjectType.Scissors,
            itemCount: SCount,
            onDrop: handleDrop,
            getGamePanelRenderBox: widget.gamePanelKey.currentState!.getGamePanelRenderBox,

          ),
        ],
      ),
    );
  }
}

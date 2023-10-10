import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_game/utils/game_object.dart';

import '../widget/game_object_widget.dart';

class GamePanel extends StatefulWidget {
  final List<GameObject> droppedObjects;

  GamePanel({required this.droppedObjects});

  @override
  _GamePanelState createState() => _GamePanelState();
}

class _GamePanelState extends State<GamePanel> {
  List<GameObject> objectsToRemove = [];

  void startGameLoop() {
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        updatePanelGameObjects();
      });
    });
  }

  void updatePanelGameObjects() {
    double panelWidth = MediaQuery
        .of(context)
        .size
        .width - 20;
    double panelHeight = MediaQuery
        .of(context)
        .size
        .height - AppBar().preferredSize.height - 220;
    for (var obj in widget.droppedObjects) {
      obj.x += obj.dx;
      obj.y += obj.dy;

      // Check and handle collisions with left and right borders
      if (obj.x < 0) {
        obj.dx *= -1;
        obj.x = 0;
      } else if (obj.x + 35 > panelWidth) {
        obj.dx *= -1;
        obj.x = panelWidth - 35;
      }

      // Check and handle collisions with top and bottom borders
      if (obj.y < 0) {
        obj.dy *= -1;
        obj.y = 0;
      } else if (obj.y + 35 > panelHeight) {
        obj.dy *= -1;
        obj.y = panelHeight - 35;
      }

      for (var otherObj in widget.droppedObjects) {
        if (obj != otherObj &&
            obj.x < otherObj.x + 35 &&
            obj.x + 35 > otherObj.x &&
            obj.y < otherObj.y + 35 &&
            obj.y + 35 > otherObj.y) {
          handleCollision(obj, otherObj);
        }
      }
    }

    for (var obj in objectsToRemove) {
      widget.droppedObjects.remove(obj);
    }
    objectsToRemove.clear();
  }


  void handleCollision(GameObject obj1, GameObject obj2) {
    if (obj1.type == obj2.type) {
      // If they're of the same type, they should just bounce off each other
      double tempDx = obj1.dx;
      double tempDy = obj1.dy;
      obj1.dx = obj2.dx;
      obj1.dy = obj2.dy;
      obj2.dx = tempDx;
      obj2.dy = tempDy;


    } else {
      // Handle the game's logic for different types
      if (obj1.type == ObjectType.Rock && obj2.type == ObjectType.Scissors) {
        objectsToRemove.add(obj2);
      } else
      if (obj1.type == ObjectType.Scissors && obj2.type == ObjectType.Rock) {
        objectsToRemove.add(obj1);
      } else
      if (obj1.type == ObjectType.Scissors && obj2.type == ObjectType.Paper) {
        objectsToRemove.add(obj2);
      } else
      if (obj1.type == ObjectType.Paper && obj2.type == ObjectType.Scissors) {
        objectsToRemove.add(obj1);
      } else
      if (obj1.type == ObjectType.Paper && obj2.type == ObjectType.Rock) {
        objectsToRemove.add(obj2);
      } else
      if (obj1.type == ObjectType.Rock && obj2.type == ObjectType.Paper) {
        objectsToRemove.add(obj1);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    startGameLoop();
  }

  RenderBox getGamePanelRenderBox() {
    return context.findRenderObject() as RenderBox;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          const Positioned.fill(
            child: Center(
              child: Text(
                "Randomly drag the following items in this erea:)",
                style: TextStyle(
                  fontSize: 18.0, // Choose a suitable font size
                  color: Colors.black, // Choose a suitable color
                ),
              ),
            ),
          ),
          for (var obj in widget.droppedObjects)
            Positioned(
              left: obj.x,
              top: obj.y,
                  child: GameObjectWidget(obj)
                  ),
        ],
      ),
    );
  }
}

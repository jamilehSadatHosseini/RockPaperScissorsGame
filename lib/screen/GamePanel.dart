import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_game/GameObject.dart';

class GamePanel extends StatefulWidget {
  final List<GameObject> droppedObjects;

  final GlobalKey<GamePanelState> gamePanelKey;

  GamePanel({required this.droppedObjects,required this.gamePanelKey});

  @override
  GamePanelState createState() => GamePanelState();
}

class GamePanelState extends State<GamePanel> {
  List<GameObject> objectsToRemove = [];

  void startGameLoop() {
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        updatePanelGameObjects();
      });
    });
  }

  void updatePanelGameObjects() {
    for (var obj in widget.droppedObjects) {
      obj.x += obj.dx;
      obj.y += obj.dy;

      // Check and handle collisions with left and right borders
      if (obj.x < 0) {
        obj.dx *= -1; // Reverse horizontal direction
        obj.x = 0;     // Set the object's x-coordinate to 0
      } else if (obj.x + 50 > 350) {
        obj.dx *= -1; // Reverse horizontal direction
        obj.x = 350 - 50; // Set the object's x-coordinate to the right edge
      }

      // Check and handle collisions with top and bottom borders
      if (obj.y < 0) {
        obj.dy *= -1; // Reverse vertical direction
        obj.y = 0;     // Set the object's y-coordinate to 0
      }
      else if (obj.y + 50 > 350) {
        obj.dy *= -1; // Reverse vertical direction
        obj.y = 350 - 50; // Set the object's y-coordinate to the bottom edge
      }

      for (var otherObj in widget.droppedObjects) {
        if (obj != otherObj &&
            obj.x < otherObj.x + 50 &&
            obj.x + 50 > otherObj.x &&
            obj.y < otherObj.y + 50 &&
            obj.y + 50 > otherObj.y) {
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
      // Bounce off each other
      double tempDx = obj1.dx;
      double tempDy = obj1.dy;
      obj1.dx = obj2.dx;
      obj1.dy = obj2.dy;
      obj2.dx = tempDx;
      obj2.dy = tempDy;
    } else {
      // Remove one of the objects
      objectsToRemove.add(obj1.type == ObjectType.Scissors ? obj1 : obj2);
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
          for (var obj in widget.droppedObjects)
            Positioned(
              left: obj.x,
              top: obj.y,
              child: Container(
                width: 35,
                height: 35,
                color: obj.type == ObjectType.Rock
                    ? Colors.red
                    : obj.type == ObjectType.Paper
                    ? Colors.blue
                    : Colors.green,
                child: Center(
                  child: Text(
                    obj.type.toString().split('.').last.characters.first,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          for (var droppedObj in widget.droppedObjects)
            Positioned(
              left: droppedObj.x,
              top: droppedObj.y,
              child: Container(
                width: 35,
                height: 35,
                color: droppedObj.type == ObjectType.Rock
                    ? Colors.red
                    : droppedObj.type == ObjectType.Paper
                    ? Colors.blue
                    : Colors.green,
                child: Center(
                  child: Text(
                    droppedObj.type.toString().split('.').last.characters.first,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

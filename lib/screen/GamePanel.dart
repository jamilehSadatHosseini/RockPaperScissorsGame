import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_game/PanelGameObject.dart';
import '../GameObject.dart';

class GamePanel extends StatefulWidget {
  const GamePanel({super.key});

  @override
  _GamePanelState createState() => _GamePanelState();
}

class _GamePanelState extends State<GamePanel> {
  List<GameItem> panelGameObjects = [];
  List<GameItem> objectsToRemove = [];

  @override
  void initState() {
    super.initState();
    createPanelGameObjects();
    startGameLoop();
  }

  void createPanelGameObjects() {
    for (int i = 0; i < 5; i++) {
      panelGameObjects .add(GameItem(type: ObjectType.Rock, x: 50, y: 50));
      panelGameObjects.add(GameItem(type: ObjectType.Paper, x: 150, y: 50));
      panelGameObjects.add(GameItem(type: ObjectType.Scissors, x: 250, y: 50));
    }
  }

  void startGameLoop() {
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        updatePanelGameObjects();
      });
    });
  }

  void updatePanelGameObjects() {
    for (var obj in panelGameObjects) {
      obj.x += obj.dx;
      obj.y += obj.dy;

      if (obj.x < 0 || obj.x > 350) {
        obj.dx *= -1;
        obj.x = obj.x.clamp(0, 350); // Keep object within the screen boundaries
      }
      if (obj.y < 0 || obj.y > 600) {
        obj.dy *= -1;
        obj.y = obj.y.clamp(0, 600); // Keep object within the screen boundaries
      }

      for (var otherObj in panelGameObjects) {
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
      panelGameObjects.remove(obj);
    }
    objectsToRemove.clear();
  }

  void handleCollision(GameItem obj1, GameItem obj2) {
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
  Widget build(BuildContext context) {
    return  Center(
        child: Stack(
          children: [
            Container(
              width: 350,
              height: 600,
              color: Colors.white,
            ),
            for (var obj in panelGameObjects)
              Positioned(
                left: obj.x,
                top: obj.y,
                child: Container(
                  width: 50,
                  height: 50,
                  color: obj.type == ObjectType.Rock
                      ? Colors.red
                      : obj.type == ObjectType.Paper
                      ? Colors.blue
                      : Colors.green,
                  child: Center(
                    child: Text(
                      obj.type.toString().split('.').last,
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
